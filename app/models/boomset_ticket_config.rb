class BoomsetTicketConfig < ActiveRecord::Base
  belongs_to :conference
  belongs_to :ticket
  belongs_to :integration

  validates :boomset_registration_type, presence: true

  def self.get_registration_types(integration)
      if integration.integration_type == "boomset"
        Boomset::get_attendee_request(integration.key, integration.integration_config_key)
      end
  end

  def self.get_boomset_integration(conference)
    Integration.boomset.where(conference_id: conference.id).first
  end
end
