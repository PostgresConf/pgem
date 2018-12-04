class Room < ActiveRecord::Base
  belongs_to :venue
  has_many :event_schedules, dependent: :destroy

  has_paper_trail ignore: [:guid], meta: { conference_id: :conference_id }

  before_create :generate_guid

  validates :name, :venue_id, presence: true

  validates :size, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  def self.day_rooms(conference_id, day)
    Room.find_by_sql("SELECT unnest(array_agg(room_id)) as room_id FROM day_rooms(#{conference_id}, '#{day}'::timestamp)")
  end

  private

  def generate_guid
    guid = SecureRandom.urlsafe_base64
    self.guid = guid
  end

  def conference_id
    venue.conference_id
  end
end
