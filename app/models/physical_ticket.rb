class PhysicalTicket < ActiveRecord::Base
  belongs_to :ticket_purchase
  belongs_to :user
  belongs_to :event
  has_one :ticket, through: :ticket_purchase
  has_one :conference, through: :ticket_purchase
  has_many :ticket_scannings

  delegate :email, to: :user
  delegate :first_name, to: :user
  delegate :last_name, to: :user
  delegate :title, to: :user
  delegate :affiliation, to: :user
  delegate :mobile, to: :user
  delegate :password, to: :user
  delegate :password_confirmation, to: :user
  delegate :position, to: :ticket

  before_create :set_token

  scope :purchased_tickets, -> (conference, user) { joins(:ticket_purchase).where('ticket_purchases.conference_id = ? and ticket_purchases.user_id = ?', conference.id, user.id) }
  scope :assigned_tickets, -> (conference, user) { joins(:ticket_purchase).where('ticket_purchases.conference_id = ? and physical_tickets.user_id = ?', conference.id, user.id) }

  def self.user_tickets(conference, user)
    ids = purchased_tickets(conference, user) + assigned_tickets(conference, user)
    where(id: ids.uniq).order(:created_at)
  end

  def self.claim_tickets(user)
    tickets = PhysicalTicket.where('lower(pending_assignment) = lower(?)', user.email)

    ActiveRecord::Base.transaction do
      tickets.each do |ticket|
        ticket.user_id = user.id
        ticket.pending_assignment = nil

        ticket_purchase = TicketPurchase.where(id: ticket.ticket_purchase_id).first
        # See if the user is registered already
        registration = Registration.where(conference_id: ticket_purchase.conference_id, user_id: user.id).first
        if registration.nil?
          registration = Registration.new(conference_id: ticket_purchase.conference_id, user_id: user.id)
          registration.save
        end

        if !ticket.event_id.nil?
          event_registration = EventsRegistration.where(registration_id: ticket.registration_id, event_id: ticket.event_id).first
          event_registration.registration_id = registration.id
          event_registration.save
        end

        ticket.registration_id = registration.id
        ticket.save

        if !PhysicalTicket.where(user_id: ticket_purchase.user_id).exists?
          remove_registration = Registration.where(conference_id: ticket_purchase.conference_id, user_id: ticket_purchase.user_id).first
          Registration.destroy(remove_registration.id)
        end

      end
    end

  end

  private

  def set_token
    self.token = PhysicalTicket.generate_token
  end

  def self.generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless PhysicalTicket.exists?(token: token)
    end
  end

    def self.assign(ticket_purchase, user, token, event_id)

      # If a token does not exists, this is a new ticket
      if token.nil?
        physical_ticket = new(ticket_purchase_id: ticket_purchase.id,
                              user_id: user.id,
                              token: PhysicalTicket.generate_token,
                              event_id: event_id)
      else
       physical_ticket = PhysicalTicket.where(token: token).first
      end

      physical_ticket.user_id = user.id

      # See if the user is registered already
      registration = Registration.where(conference_id: ticket_purchase.conference_id, user_id: user.id).first
      if registration.nil?
        registration = Registration.new(conference_id: ticket_purchase.conference_id, user_id: user.id)
        registration.save
      end

      physical_ticket.registration_id = registration.id

      if !event_id.nil?
        event_registration = EventsRegistration.new(registration_id: registration.id, event_id: event_id)
        event_registration.save
      end

      physical_ticket.save
    end

end
