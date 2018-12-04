class DuplicateTicket < ActiveRecord::Base
  after_initialize :readonly!

  belongs_to :conference
  belongs_to :user
  belongs_to :ticket
end
