module Admin
  module Reports
    class CodesController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        @codes = @conference.codes.joins(:ticket_purchases)
            .where("ticket_purchases.code_id IS NOT NULL")
            .distinct
            .order(:name)
      end
    end
  end
end
