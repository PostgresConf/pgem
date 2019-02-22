class Integration < ActiveRecord::Base
  belongs_to :conference

  enum integration_type: [:boomset, :mailchimp, :sched]

  validates :integration_type, presence: true

  def update_registration(registration)
    if self.integration_type == "boomset"
      BoomsetAttendeeRegisterJob.perform_later(registration)
    end
  end

  def update_event(event)
    if self.integration_type == "sched"
      SchedSessionSyncJob.perform_later(event)
    end
  end

  def self.has_boomset?(conference)
    Integration.where(conference_id: conference.id, integration_type: integration_types[:boomset]).exists?
  end

  def self.has_sched?(conference)
    Integration.where(conference_id: conference.id, integration_type: integration_types[:sched]).exists?
  end

  def self.get_sched_integration(conference)
    Integration.sched.where(conference_id: conference.id).first
  end

end
