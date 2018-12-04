class TicketGroupBenefitsTicket < ActiveRecord::Base
  has_many :ticket_group_benefits
  has_many :tickets
end
