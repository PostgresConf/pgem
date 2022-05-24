module Admin
    module Reports
      class PurchasesController < Admin::BaseController
        load_and_authorize_resource :conference, find_by: :short_title

        def index
          @purchases = @conference.ticket_purchases.order(:created_at)
        end
      end
    end
  end
