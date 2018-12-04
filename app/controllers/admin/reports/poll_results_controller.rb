module Admin
  module Reports
    class PollResultsController < Admin::BaseController
      load_and_authorize_resource :conference, find_by: :short_title
      load_and_authorize_resource :poll, through: :conference, singleton: true
      load_and_authorize_resource :survey, through: :poll, singleton: true

      def index
        @poll_results = PollResult.joins(:survey_question)
      end
    end
  end
end
