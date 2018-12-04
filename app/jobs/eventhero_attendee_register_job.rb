class EventheroAttendeeRegisterJob < ActiveJob::Base
  require 'rest-client'
  require 'eventhero'

  queue_as :default

  def perform(registration)
    if Rails.application.secrets.eventhero_access_key.blank?
      raise RuntimeError, "Access Key missing"
    else
      access_key = Rails.application.secrets.eventhero_access_key
    end

    url = "https://app.eventhero.io/api/registrations"
    content_type = "application/vnd.eventhero.registrations.v1+json"
    auth = "Authorization: Bearer " + access_key

    request = EventheroAttendeeRegisterJob.get_eventhero_request(registration)

    RestClient.post url, request, {content_type: content_type, authorization: auth}
  end

  private

  def self.get_eventhero_request(registration)
    payload = EventHero.new
    payload.type = "registration.confirmed"

    payload.data = EventHero::Data.new
    payload.data.id = registration.conference.short_title + "_" + registration.id.to_s

    payload.data.type = EventHero::Data::Type.new
    payload.data.type.id = registration.type
    payload.data.type.name = registration.type

    payload.data.event = EventHero::Data::Event.new
    payload.data.event.name = registration.conference.title

    payload.data.registrant = EventHero::Data::Registrant.new
    unless registration.first_name.blank?
      payload.data.registrant.first_name = registration.first_name
    end

    unless registration.last_name.blank?
      payload.data.registrant.last_name = registration.last_name
    end

    unless registration.title.blank?
      payload.data.registrant.job_title = registration.title
    end

    unless registration.affiliation.blank?
      payload.data.registrant.company = registration.affiliation
    end

    unless registration.mobile.blank?
      payload.data.registrant.phone = registration.mobile
    end

    unless registration.email.blank?
      payload.data.registrant.email = registration.email
    end

    payload.to_json
  end

end
