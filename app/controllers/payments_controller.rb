class PaymentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  load_resource :conference, find_by: :short_title
  authorize_resource :conference_registrations, class: Registration
  before_action :setup_payment_client

  # FIXME: probably unused method
  def index
    @payments = current_user.payments
  end

  def new
    @applied_code = Code.where(id: session[:applied_code_id]).take
    @total_amount_to_pay = Ticket.total_price(@conference, current_user, @applied_code, paid: false)
    @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)
    @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
  end

  def create
    @applied_code = Code.where(id: session[:applied_code_id]).take
    @payment = Payment.new payment_params
    @payment.applied_code = @applied_code
    if @payment.purchase && @payment.save
      update_purchased_ticket_purchases
      # purchase complete => remove applied promocode from the session
      session.delete(:applied_code_id)
      Mailbot.purchase_confirmation_mail(@payment).deliver_later if @conference.contact.email.present?
      redirect_to complete_conference_tickets_path,
                  notice: 'Thanks! Your ticket is booked successfully.'
    else
      @total_amount_to_pay = Ticket.total_price(@conference, current_user, @applied_code, paid: false)
      @unpaid_quantity = Ticket.total_quantity(@conference, current_user, paid: false)
      @unpaid_ticket_purchases = current_user.ticket_purchases.unpaid.by_conference(@conference)
      flash[:error] = @payment.errors.full_messages.to_sentence + ' Please try again with correct credentials.'
      render :new
    end
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

  def setup_payment_client
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
    elsif @conference.payment_method.gateway == 'stripe'
      Stripe.api_key = @conference.payment_method.stripe_secret_key
    end
  end
end
