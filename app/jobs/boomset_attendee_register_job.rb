class BoomsetAttendeeRegisterJob  < ActiveJob::Base 
  require 'rest-client'
  require 'json'

  def self.perform(registration)
      guest = BoomsetGuest.get_guest(registration)

      integration = BoomsetTicketConfig.get_boomset_integration(registration.conference)
      if integration.integration_type == "boomset"
	  guest_exists = false

	  boomset_guest = BoomsetGuest.where(conference_id: registration.conference.id, token: guest.barcode).first
          if boomset_guest.blank?
	      boomset_guest = BoomsetGuest.where(conference_id: registration.conference.id, registration_id: registration.id).first
	      if boomset_guest.present?
	          guest_exists = true
	      end
          else
	      guest_exists = true
          end

	  if guest_exists
	      id = Boomset.update_guest(integration.key, integration.integration_config_key, boomset_guest.boomset_guest, guest.to_json)
	      if id > 0
	          boomset_guest.registration_id = registration.id
		  boomset_guest.boomset_guest = id
		  boomset_guest.update
	      end
	  else
	      id = Boomset.add_guest(integration.key, integration.integration_config_key, guest.to_json)
	      if id > 0
	          token = guest.barcode
	          bg = BoomsetGuest.new
	          bg.conference_id = registration.conference.id
	          bg.registration_id = registration.id
	          bg.integration_id = integration.id
	          bg.boomset_guest = id
	          bg.token = token
	          bg.save
	      end
          end
      end


  end

end
