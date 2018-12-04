class TicketGroup < ActiveRecord::Base
  belongs_to :conference
  acts_as_list scope: :conference
  has_many :tickets
  has_many :ticket_group_benefits

  validates :name, presence: true

  default_scope { order(position: :asc) }
end
