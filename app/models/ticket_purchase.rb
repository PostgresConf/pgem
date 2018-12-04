class TicketPurchase < ActiveRecord::Base
  belongs_to :ticket
  belongs_to :user
  belongs_to :conference

  belongs_to :code
  belongs_to :event

  belongs_to :payment

  validates :ticket_id, :user_id, :conference_id, :quantity, presence: true

  validates_numericality_of :quantity, greater_than: 0

  delegate :title, to: :ticket
  delegate :description, to: :ticket
  delegate :price, to: :ticket
  delegate :adjusted_price, to: :ticket
  delegate :price_cents, to: :ticket
  delegate :price_currency, to: :ticket

  monetize :purchase_price_cents, with_model_currency: :purchase_price_currency

  has_many :physical_tickets

  scope :paid, -> { where(paid: true) }
  scope :unpaid, -> { where(paid: false) }
  scope :by_conference, -> (conference) { where(conference_id: conference.id) }
  scope :by_user, -> (user) { where(user_id: user.id) }

  def total_purchase_price
    tpp = purchase_price_cents * quantity
    Money.new(tpp, conference.default_currency)
  end

  def self.total_payments(conference, ticket)
    total_paid = TicketPurchase.where(ticket_id: ticket.id, paid: true,
                         conference_id: conference.id).joins(:payment).sum(:amount)

    Money.new(total_paid, conference.default_currency)
  end

  def self.purchase(conference, user, purchases, code_id, chosen_events, prices)
    errors = []
    ActiveRecord::Base.transaction do
      conference.tickets.each do |ticket|
        chosen_event_list = nil 
        if chosen_events.present?
          chosen_events.each do |key, value|
            if key == ticket.id.to_s
              chosen_event_list = value
            end
          end
        end

        quantity = purchases[ticket.id.to_s].to_i
        price = prices[ticket.id.to_s].to_f
        # if the user bought the ticket, just update the quantity
        if ticket.bought?(user) && ticket.unpaid?(user)
          purchase = update_quantity(conference, quantity, ticket, user)
        else
          purchase = purchase_ticket(conference, quantity, ticket, user, code_id, chosen_event_list, price)
        end

        if purchase && !purchase.save
          errors.push(purchase.errors.full_messages)
        end
      end
    end
    errors.join('. ')
  end

  def self.purchase_ticket(conference, quantity, ticket, user, code_id, event_list, price)
    if quantity > 0
      purchase = new(ticket_id: ticket.id,
                     conference_id: conference.id,
                     user_id: user.id,
                     quantity: quantity,
                     code_id: code_id,
                     pending_event_tickets: event_list,
                     purchase_price: price)
      purchase.pay(nil, user) if ticket.price_cents.zero?
    end
    purchase
  end

  def self.update_quantity(conference, quantity, ticket, user)
    purchase = TicketPurchase.where(ticket_id: ticket.id,
                                    conference_id: conference.id,
                                    user_id: user.id,
                                    paid: false).first

    purchase.quantity = quantity if quantity > 0
    purchase
  end

  def pay(payment, user)
    if self.pending_event_tickets.present?
      pending_tkts = eval(self.pending_event_tickets)
    end
    update_attributes(paid: true, payment: payment, pending_event_tickets: nil)
    PhysicalTicket.transaction do
      if pending_tkts.present?
        pending_tkts.each do |evt, qty|
          if qty.present?
            for i in 1..qty.to_i
              physical_tickets.assign(self, user, nil, evt.to_i)
            end
          end
        end      
      else
        quantity.times { physical_tickets.assign(self, user, nil, nil) }
      end
    end
    Mailbot.ticket_confirmation_mail(self).deliver_later
  end

  def self.get_code_usage(conference, code)
    usage = TicketPurchase.where(conference_id: conference.id, code_id: code.id).sum(:quantity)
    usage
  end
end
