class TicketGroup < ActiveRecord::Base
  belongs_to :conference
  acts_as_list scope: :conference
  has_many :tickets

  validates :name, presence: true

  default_scope { order(position: :asc) }
end
