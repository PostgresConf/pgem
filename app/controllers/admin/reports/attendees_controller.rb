module Admin
  module Reports
    class AttendeesController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        @attendees = @conference.registrations.sort_by &:last_name
      end
    end
  end
end
