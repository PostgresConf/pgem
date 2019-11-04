module Api
    module V1
      class ScheduleController < Api::BaseController
        load_resource :conference, find_by: :short_title
        respond_to :json
  
        # Disable forgery protection for any json requests. This is required for jsonp support
        skip_before_action :verify_authenticity_token
  
        def index
          @scheduled_events = @conference.program.selected_schedule.events
          render json: [@scheduled_events]#, serializer: EventScheduleSerializer, callback: params['callback']
        end
      end
    end
  end
  