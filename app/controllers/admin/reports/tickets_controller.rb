module Admin
  module Reports
    class TicketsController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        @physical_tickets = @conference.physical_tickets.order(:created_at).where("ticket_purchases.paid = true")
      end
    end
  end
end
