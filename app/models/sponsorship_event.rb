class SponsorshipEvent < ActiveRecord::Base
  after_initialize :readonly!

  belongs_to :sponsor
  belongs_to :conference
  belongs_to :sponsorship_levels_benefit

  scope :tasks , -> (conference) { where(event_type: 'task', conference_id: conference.id) }

  def overdue_tasks
    tasks.where(start_date.lt(Date.today))
  end
end
