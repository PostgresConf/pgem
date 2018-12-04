module Admin
  module Reports
    class PaymentsController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title

      def index
        @payments = @conference.payments.order(:created_at).where(status: 1)
      end
    end
  end
end
