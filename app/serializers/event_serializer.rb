class EventSerializer < ActiveModel::Serializer
  include ActionView::Helpers::TextHelper

  attributes :guid, :title, :length, :scheduled_date, :language, :abstract, :speakers, :type, :room, :track
  has_many :speakers, serializer: SpeakerSerializer
  has_one :room, serializer: RoomSerializer
  has_one :track, serializer: TrackSerializer

  def scheduled_date
    t = object.time
    t.blank? ? '' : %(#{I18n.l t, format: :short}#{t.formatted_offset(false)})
  end

  def type
    object.event_type.try(:title)
  end

  def room
    object.try(:room)
  end

  def track
    object.try(:track)
  end

  def length
    object.event_type.try(:length) || EventType::LENGTH_STEP
  end
end
