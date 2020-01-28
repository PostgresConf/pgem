module Refinery
  module Meetups
    class MeetupsController < ::ApplicationController

      before_action :find_all_meetups
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @meetup in the line below:
        present(@page)
      end

      def show
        @meetup = Meetup.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @meetup in the line below:
        present(@page)
      end

    protected

      def find_all_meetups
        @meetups = Meetup.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/meetups").first
      end

    end
  end
end
