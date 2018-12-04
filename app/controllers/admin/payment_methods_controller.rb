module Admin
  class PaymentMethodsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, singleton: true
 
    def show; end

    def edit; end

    def create
      @payment_method = @conference.build_payment_method(payment_method_params)

      if @payment_method.save
        redirect_to admin_conference_payment_method_path,
                    notice: 'Payment Method was successfully created.'
      else
        render :new
      end
    end

    def update
      if @payment_method.update_attributes(payment_method_params)
        redirect_to admin_conference_payment_method_path(conference_id: @conference.short_title),
                    notice: 'Payment Method was successfully updated.'
      else
        flash.now[:error] = "Update Payment Method failed: #{@payment_method.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    private

    def payment_method_params
      params.require(:payment_method).permit(:gateway, :stripe_publishable_key, :stripe_secret_key,
                                             :braintree_merchant_id, :braintree_public_key,
                                             :braintree_private_key, :braintree_merchant_account,
                                             :braintree_environment, :payu_store_name,
                                             :payu_store_id, :payu_webservice_name,
                                             :payu_webservice_password, :payu_signature_key, 
                                             :payu_service_domain)
    end
  end
end
