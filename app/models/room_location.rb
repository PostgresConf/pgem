class RoomLocation < ActiveRecord::Base
  belongs_to :venue
  has_many :rooms, dependent: :nullify

end
