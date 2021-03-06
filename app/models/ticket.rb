class Ticket < ActiveRecord::Base
  belongs_to :conference
  belongs_to :ticket_group
  acts_as_list scope: :conference

  has_many :ticket_purchases, dependent: :destroy
  has_many :events
  has_many :buyers, -> { distinct }, through: :ticket_purchases, source: :user
  has_many :payments, through: :ticket_purchases
  has_many :ticket_group_benefits, through: :ticket_group_benefits_tickets

  has_and_belongs_to_many :codes, :join_table => :codes_tickets

  cattr_accessor :applied_code

  enum ticket_type: [:normal, :date_range, :day_pass]

  has_paper_trail meta: { conference_id: :conference_id }

  monetize :price_cents, with_model_currency: :price_currency
  monetize :early_bird_price_cents, with_model_currency: :early_bird_price_currency

  # This validation is for the sake of simplicity.
  # If we would allow different currencies per conference we also have to handle convertions between currencies!
  validate :tickets_of_conference_have_same_currency

  validates :price_cents, :price_currency, :title, presence: true
  validates :max_per_purchase, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100}

  validates_numericality_of :price_cents, greater_than_or_equal_to: 0

  scope :visible, -> { where(hidden: false) }

  def day_range
    dr = 'Attend the conference'

    if self.ticket_type == 'day_pass'
      dr = 'Choose your day'
    elsif self.ticket_type == 'date_range'
      if !self.end_date.blank? && !self.start_date.blank?
        dr = self.start_date.strftime("%A") + ' - ' + self.end_date.strftime("%A")
      end
    end

    dr
  end

  def bought?(user)
    buyers.include?(user)
  end

  def paid?(user)
    ticket_purchases.paid.by_user(user).present?
  end

  def quantity_bought_by(user, paid: false)
    ticket_purchases.by_user(user).where(paid: paid).sum(:quantity)
  end

  def unpaid?(user)
    ticket_purchases.unpaid.by_user(user).present?
  end

  def has_benefit?(benefit)
    TicketGroupBenefitsTicket.where(ticket_group_benefit_id: benefit.id, ticket_id: self.id).exists?
  end
  
  def total_price(user, paid: false)
    quantity_bought_by(user, paid: paid) * adjusted_price
  end

  def self.total_quantity(conference, user, paid: false)
    TicketPurchase.where(conference_id: conference.id, user_id: user.id, paid: paid).sum(:quantity)
  end

  def self.total_price(conference, user, paid: false)
    tickets = Ticket.where(conference_id: conference.id)
    result = nil
    begin
      tickets.each do |ticket|
        price = ticket.total_price(user, paid: paid)
        if result
          result +=  price unless price.zero?
        else
          result = price
        end
      end
    rescue Money::Bank::UnknownRate
      result = Money.new(-1, 'USD')
    end
    result ? result : Money.new(0, 'USD')
  end

  def tickets_sold
    ticket_purchases.paid.sum(:quantity)
  end

  def current_price
    conference = Conference.find(conference_id)
    cur_price = price
    if conference.early_bird_open? && early_bird_price_cents > 0
      cur_price = early_bird_price
    end
    cur_price
  end

  def adjusted_price
    if applied_code.present?
      if Ticket.where(id: id).joins(:codes).where("codes.id = ?", applied_code.id).count > 0
        adj_price = current_price - (current_price * ((applied_code.discount.to_f) / 100.0))
      else
        adj_price = current_price
      end
    else
      adj_price = current_price
    end
    adj_price
  end

  def self.visible_tickets
    if applied_code.present?
      if applied_code.code_type.title == 'Access'
        where(hidden: true).joins(:codes).where("codes.id = ?", applied_code.id) | where(hidden: false)
      else
        where(hidden: false)
      end
    else
      where(hidden: false)
    end
  end

  def ticketed_events
    events.where(ticket_id: id)
  end

  # This will return the maximum number of tickets available within one purchase, maxing out at max_per_purchase
  def purchase_quantity_available
    available = max_per_purchase
    if applied_code.present?
      if Ticket.where(id: id).joins(:codes).where("codes.id = ?", applied_code.id).count > 0
	      if applied_code.max_uses != 0
          available = applied_code.max_uses - TicketPurchase.get_code_usage(conference, applied_code)
          if available < 0
            available = 0
          end
	      end
      end
    end
    available
  end

  def self.visible_group_tickets(conference, ticket_group)
    Ticket.where(conference_id: conference.id, ticket_group_id: ticket_group.id, hidden: false).order(:position)
  end

  private

  def tickets_of_conference_have_same_currency
    unless Ticket.where(conference_id: conference_id).all?{|t| t.price_currency == self.price_currency }
      errors.add(:price_currency, 'is different from the existing tickets of this conference.')
    end
  end
end
