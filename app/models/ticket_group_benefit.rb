class TicketGroupBenefit < ActiveRecord::Base
  belongs_to :ticket_group
  acts_as_list scope: :ticket_group

  has_and_belongs_to_many :tickets, :join_table => :ticket_group_benefits_tickets

  validates :name, presence: true
  validates :description, presence: true

  default_scope { order(position: :asc) }
  
  def ticket_group_name
    TicketGroup.where(id: self.ticket_group_id).pluck(:name).first
  end
end
