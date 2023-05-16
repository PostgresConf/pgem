class Payment < ActiveRecord::Base
  has_many :ticket_purchases
  belongs_to :user
  belongs_to :conference

  attr_accessor :stripe_customer_email
  attr_accessor :stripe_customer_token
  attr_accessor :payment_method_nonce
  attr_accessor :applied_code

  validates :status, presence: true
  validates :user_id, presence: true
  validates :conference_id, presence: true

  enum status: {
    unpaid: 0,
    success: 1,
    failure: 2,
    pending: 3,
    canceled: 4
  }

  def amount_to_pay
    Ticket.total_price(conference, user, applied_code, paid: false)
  end

  def amount_as_money
    Money.new(amount, conference.default_currency)
  end

  def masked_card_no
    if last4.present?
      'xxxx-xxxxxx-x' + last4
    else
      'xxxx-xxxxxx-xxxxx'
    end
  end

  def self.by_reference(ref)
    payment = Payment.where(reference: ref).first
    payment
  end

  def self.purchases(conference, user)
    payments = Payment.where(conference_id: conference.id, user_id: user.id, status: 1).order(:created_at)
    payments
  end

  def purchase
    if amount_to_pay == 0
      self.amount = 0
      self.status = 'success'
      return true
    end

    if conference.payment_method.present?
      return self.send "purchase_with_#{conference.payment_method.gateway}"
    else
      errors.add(:base, "No payment method configured for this conference")
      self.status = 'failure'
      return false
    end
  end

  private
    def purchase_with_stripe
      begin
        gateway_response = Stripe::Charge.create source: stripe_customer_token,
        receipt_email: stripe_customer_email,
        description: "ticket purchases(#{user.username})",
        amount: amount_to_pay.cents,
        currency: conference.tickets.first.price_currency

        self.amount = gateway_response[:amount]
        self.last4 = gateway_response[:source][:last4]
        self.authorization_code = gateway_response[:id]
        self.status = 'success'
      rescue Stripe::StripeError => error
        errors.add(:base, error.message)
        self.status = 'failure'
        return false
      end
      true
    end

    def purchase_with_braintree
      result = Braintree::Transaction.sale(
        :amount => -1,
        :payment_method_nonce => self.payment_method_nonce,
        :merchant_account_id => conference.payment_method.braintree_merchant_account,
        :customer => {
            :email => user.email,
            :first_name => user.first_name,
            :last_name => user.last_name
        },
        :options => {
            :submit_for_settlement => true
        }

      )
      if result.success?
        self.authorization_code = result.transaction.id
        self.amount = result.transaction.amount * 100
        self.last4 = result.transaction.credit_card_details.last_4
        self.status = 'success'
        return true
      else
        @error_messages = result.errors.map { |error| "Error: #{error.code}: #{error.message}" }
        errors.add(:base, @error_messages)
        return false
      end
    end

    # FIXME: legacy payu is a candidate for removal
    def purchase_with_payu
      return false
    end
end
