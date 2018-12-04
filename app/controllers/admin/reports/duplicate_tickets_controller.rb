module Admin
  module Reports
    class DuplicateTicketsController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        @duplicates = @conference.duplicate_tickets
      end
    end
  end
end
