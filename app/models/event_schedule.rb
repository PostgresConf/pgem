class EventSchedule < ActiveRecord::Base
  belongs_to :schedule
  belongs_to :event
  belongs_to :room

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }

  validates :schedule, presence: true
  validates :event, presence: true
  validates :room, presence: true
  validates :start_time, presence: true
  validates :event, uniqueness: { scope: :schedule }

  scope :confirmed, -> { joins(:event).where('state = ?', 'confirmed') }
  scope :canceled, -> { joins(:event).where('state = ?', 'canceled') }
  scope :withdrawn, -> { joins(:event).where('state = ?', 'withdrawn') }

  delegate :guid, to: :room, prefix: true

  ##
  # Returns end of the event
  #
  def end_time
    start_time + event.event_type.length.minutes
  end

  ##
  # Returns events that are scheduled in the same room and start_time as event
  #
  def intersecting_events
    room.event_schedules.where(start_time: start_time, schedule: schedule).where.not(id: id)
  end

  def self.event_at_time(room, at_time, step_minutes)
    interval_end = at_time + step_minutes
    room.event_schedules.where('start_time >= ? and start_time < ?', at_time, interval_end).first
  end

  private

  def conference_id
    schedule.program.conference_id
  end
end
