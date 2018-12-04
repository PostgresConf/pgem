class PaymentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  load_resource :conference, find_by: :short_title
  authorize_resource :conference_registrations, class: Registration
  before_action :init_payment_object

  def index
    @payments = current_user.payments
  end

  def new
    @total_amount_to_pay = Ticket.total_price(@conference, current_user, paid: false)
    @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)
    @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
    
    if @conference.payment_method.gateway == 'braintree'
      gon.client_token = generate_client_token
    end
  end

  def create
   if @conference.payment_method.gateway == 'braintree'
      nonce = params[:payment_method_nonce]

      result = Braintree::Transaction.sale(
        :amount => Ticket.total_price(@conference, current_user, paid: false),
        :payment_method_nonce => nonce,
        :merchant_account_id => @conference.payment_method.braintree_merchant_account,
        :customer => {
            :email => current_user.email,
            :first_name => current_user.first_name,
            :last_name => current_user.last_name
        },
        :options => {
            :submit_for_settlement => true
        }

     )
      if result.success? == true
        @payment = Payment.new payment_params
        @payment.authorization_code = result.transaction.id
        @payment.amount = result.transaction.amount * 100 
        @payment.last4 = result.transaction.credit_card_details.last_4
        @payment.status = 1

        if @payment.save
          update_purchased_ticket_purchases
          Mailbot.purchase_confirmation_mail(@payment).deliver_later
          redirect_to conference_physical_ticket_index_path,
                     notice: 'Thanks! Your ticket is booked successfully.'
        end
      else
        @total_amount_to_pay = Ticket.total_price(@conference, current_user, paid: false)
        @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
        @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)
        @error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
        flash[:notice] = result.message 
        render "new"
      end
   elsif @conference.payment_method.gateway == 'payu'
     request = @client.request('setTransaction') 

     request.header.__node__ << @wsse.to_xml

     req = ActionDispatch::Request.new 'HTTP_HOST'
     base = req.protocol + req.host_with_port()

     amt = Ticket.total_price(@conference, current_user, paid: false).cents

     request.body do |b|
       b.Api 'ONE_ZERO'
       b.Safekey @conference.payment_method.payu_signature_key
       b.TransactionType 'PAYMENT'
       b.AdditionalInformation do |ai|
         ai.merchantReference @conference.payment_method.payu_store_name
         ai.supportedPaymentMethods 'CREDITCARD,MASTERPASS,EFT,EFT_PRO'
         ai.returnUrl url_for :controller => 'payments', :action => 'confirm'
         ai.cancelUrl url_for :controller => 'payments', :action => 'cancel'
       end
       b.Customer do |c|
         c.firstName current_user.first_name
         c.lastName current_user.last_name
         c.email current_user.email
         c.merchantUserId current_user.id
       end
       b.Basket do |bk|
         bk.amountInCents amt
         bk.currencyCode @conference.default_currency
       end
     end

    http_msg = @http.post(request.url, request.content)
    http_msg = @http.post(request.url, request.content)
    response = @client.response(request, http_msg.content)

   rh = response.body_hash
   success = true
   
   if rh.key?("faultstring")
     success = false
     err = rh.fetch("faultstring") 
   end
   
   ref = ''
   if rh.key?("return")
     ret = rh.fetch("return")
     if ret.fetch("successful") == "false"
       success = false
       err = ret.fetch("displayMessage")
     else
       success = true
       ref = ret.fetch("payUReference")
     end
   end
   
   if success == false
     @total_amount_to_pay = Ticket.total_price(@conference, current_user, paid: false)
     @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
     @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)

     flash[:error] = "Server error: " + err 
     render "new"
   else
     @payment = Payment.new payment_params
     @payment.amount = amt
     @payment.status = 'pending'
     @payment.user_id = current_user.id
     @payment.reference = ref
     @payment.save

     @base_url = 'https://' + @conference.payment_method.payu_service_domain
     redirect_url = @base_url + '/rpp.do?PayUReference=' + ref
     redirect_to redirect_url
   end

   else
     @payment = Payment.new payment_params

     if @payment.purchase && @payment.save
       update_purchased_ticket_purchases
       Mailbot.purchase_confirmation_mail(@payment).deliver_later
       redirect_to conference_physical_ticket_index_path, 
                   notice: 'Thanks! Your ticket is booked successfully.'
     else
       @total_amount_to_pay = Ticket.total_price(@conference, current_user, paid: false)
       @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
       @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)
       flash[:error] = @payment.errors.full_messages.to_sentence + ' Please try again with correct credentials.'
     end
    end
  end

  def confirm
    ref = params[:PayUReference]

    request = @client.request('getTransaction') 

    request.header.__node__ << @wsse.to_xml

    request.body do |b|
      b.Api 'ONE_ZERO'
      b.Safekey @conference.payment_method.payu_signature_key
      b.AdditionalInformation do |ai|
        ai.payUReference ref
      end
    end

    http_msg = @http.post(request.url, request.content)
    http_msg = @http.post(request.url, request.content)
    response = @client.response(request, http_msg.content)

    rh = response.body_hash
    success = true

    if rh.key?("faultstring")
      success = false
      err = rh.fetch("faultstring") 
    end
   
    if rh.key?("return")
      ret = rh.fetch("return")
      if ret.fetch("successful") == "false"
        success = false
        err = ret.fetch("displayMessage")
      else
        success = true
        pmu = ret.fetch("paymentMethodsUsed")
        last4 = pmu[0].fetch("cardNumber").last(4)
        amt = pmu[0].fetch("amountInCents")
        auth_code = pmu[0].fetch("gatewayReference")
      end
    end

    if success == false
      @total_amount_to_pay = Ticket.total_price(@conference, current_user, paid: false)
      @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
      @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)

      flash[:error] = "Server error: " + err 
      render "new"
   else
     @payment = Payment.by_reference(ref)
     @payment.status = 'success'
     @payment.amount = amt
     @payment.last4 = last4
     @payment.authorization_code = auth_code
     if @payment.save
       update_purchased_ticket_purchases
       Mailbot.purchase_confirmation_mail(@payment).deliver_later
       redirect_to conference_physical_ticket_index_path,
                notice: 'Thanks! Your ticket is booked successfully.'
     end
   end

  end

  def cancel
    ref = params[:PayUReference]
    @payment = Payment.by_reference(ref)
    @payment.status = 'canceled'
    @payment.save

    @total_amount_to_pay = Ticket.total_price(@conference, current_user, paid: false)
    @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
    @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)

    flash[:notice] = 'Payment Canceled' 
    render "new"
  end

  def payment_params
    params.permit(:stripe_customer_email, :stripe_customer_token, :payment_method_nonce)
        .merge(stripe_customer_email: params[:stripeEmail],
               stripe_customer_token: params[:stripeToken],
               user: current_user, conference: @conference)
  end

  def update_purchased_ticket_purchases
    current_user.ticket_purchases.by_conference(@conference).unpaid.each do |ticket_purchase|
      ticket_purchase.pay(@payment, current_user)
    end
  end
  private

  def generate_client_token
    Braintree::ClientToken.generate
  end

  def init_payment_object
    if @conference.payment_method.gateway == 'braintree'
      Braintree::Configuration.environment = @conference.payment_method.braintree_environment
      Braintree::Configuration.merchant_id = @conference.payment_method.braintree_merchant_id
      Braintree::Configuration.public_key = @conference.payment_method.braintree_public_key
      Braintree::Configuration.private_key = @conference.payment_method.braintree_private_key
    elsif @conference.payment_method.gateway == 'payu'
      @http = HTTPClient.new

      @base_url = 'https://' + @conference.payment_method.payu_service_domain
      wsdl_url = @base_url + '/service/PayUAPI?wsdl'
      wsdl = @http.get_content wsdl_url

      @client = LolSoap::Client.new(wsdl)

      username = @conference.payment_method.payu_webservice_name
      password = @conference.payment_method.payu_webservice_password
      @wsse = Akami.wsse
      @wsse.credentials(username, password)

    end
  end  
end
