module Refinery
  module CommunityEvents
    module Admin
      class CommunityEventsController < ::Refinery::AdminController

        crudify :'refinery/community_events/community_event'

        private

        # Only allow a trusted parameter "white list" through.
        def community_event_params
          params.require(:community_event).permit(:title, :body, :url, :published_at, :author)
        end
      end
    end
  end
end
