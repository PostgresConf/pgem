module Refinery
  module Meetups
    module Admin
      class MeetupsController < ::Refinery::AdminController

        crudify :'refinery/meetups/meetup'

        private

        # Only allow a trusted parameter "white list" through.
        def meetup_params
          params.require(:meetup).permit(:external_id, :title, :description, :url, :start, :end, :location)
        end
      end
    end
  end
end
