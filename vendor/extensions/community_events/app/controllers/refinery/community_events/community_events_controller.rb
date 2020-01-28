module Refinery
  module CommunityEvents
    class CommunityEventsController < ::ApplicationController

      before_action :find_all_community_events
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @community_event in the line below:
        present(@page)
      end

      def show
        @community_event = CommunityEvent.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @community_event in the line below:
        present(@page)
      end

    protected

      def find_all_community_events
        @community_events = CommunityEvent.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/community_events").first
      end

    end
  end
end
