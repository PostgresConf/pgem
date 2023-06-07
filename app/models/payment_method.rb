class PaymentMethod < ActiveRecord::Base
  belongs_to :conference

  GATEWAYS = [['Braintree', 'braintree'], ['Stripe', 'stripe']]

  BRAINTREE_ENVS = [['Production', 'production'], ['Sandbox', 'sandbox']]

  default_scope { where(environment: Rails.env) }
end
