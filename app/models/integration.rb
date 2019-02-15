class Integration < ActiveRecord::Base
  belongs_to :conference

  enum integration_type: [:boomset, :mailchimp]

  validates :integration_type, presence: true

  def self.has_boomset?(conference)
    Integration.where(conference_id: conference.id, integration_type: integration_types[:boomset]).exists?
  end
end
