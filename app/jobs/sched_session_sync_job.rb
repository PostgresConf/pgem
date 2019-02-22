class SchedSessionSyncJob < ActiveJob::Base 
  require 'redcarpet'
  require 'sched'

  def perform(event)
    unless event.nil?
      if Integration.has_sched?(event.program.conference)
	integration = Integration.get_sched_integration(event.program.conference)
        session = SchedSessionSyncJob.get_session(event)

	# Sched has a rate limit of 30 request per second so sleep for 6 seconds
	# to make sure we don't violate the limit. Each job run will make at 
	# least 2 API requests to check if the session exists and then to save it
        sleep 6

        sched = Sched::Client.new(integration.integration_config_key, integration.key)
	sched_event = sched.event(event.guid)

	# The session does not exist if we do not have an pgem schedule so it
	# was likely deleted. It that case we want to delete the event in Sched
        if session.nil?

	  # Only try to delete the event if it exists in Sched already
	  if sched_event.exists?
	    response = sched_event.destroy
            if response != "Ok"
              raise response
            end
	  end
        else
	  begin
	    sched_event.name = session.name
	    sched_event.session_start = session.session_start
	    sched_event.session_end = session.session_end
	    sched_event.session_type = session.session_type
	    sched_event.session_subtype = session.session_subtype
	    sched_event.description = session.description
            sched_event.venue = session.venue
	    sched_event.address = session.address
	    sched_event.active = session.active

	    response = sched_event.save
	    if response != "Ok"
	      raise response
	    end
	  rescue => e
	    # We likely got here becuase we are trying to add an existing event
	    # so update it instead
            response = sched_event.update
            if response != "Ok"
              raise response
            end
          end
        end
      end
    end
  end

  def self.get_session(event)
    session = nil

    es = EventSchedule.where(event_id: event.id).first

    unless es.blank?	
      session = SchedSession.new
      session.session_key = event.guid
      session.name = event.title

      conference = event.program.conference
      session.session_start = es.start_time.in_time_zone(conference.timezone).strftime('%Y-%m-%d %H:%M')
      session.session_end = es.end_time.in_time_zone(conference.timezone).strftime('%Y-%m-%d %H:%M')

      session.session_type = event.event_type.title
      session.session_subtype = event.track.name

      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
      session.description = markdown.render(event.abstract)

      session.venue = es.room.name
      session.address = es.room.room_location.description

      if event.state = "confirmed"
        session.active = "Y"
      else
	session.active = "N"
      end
    end

    session
  end
end
