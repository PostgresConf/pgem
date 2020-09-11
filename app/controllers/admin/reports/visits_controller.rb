module Admin
  module Reports
    class VisitsController < Admin::BaseController
      skip_authorization_check
      def index
        @report_title = 'Visit Report'
        @campaign = report_params.fetch(:campaign, nil)
        @utm_campaign = report_params.fetch(:utm_campaign, [])
        @utm_medium = report_params.fetch(:utm_medium, [])
        @utm_source = report_params.fetch(:utm_source, [])

        if @campaign.present?
          campaign = Campaign.find(@campaign)
          conditions = campaign.get_parameters
          @visits = Ahoy::Visit.where(conditions)
          @base_scope = @visits
          @report_title = "Visit Report for \"#{campaign.name}\" campaign."
        else
          @start_date = report_params.fetch(:start_date, '').to_date || Date.today()-3.months
          @end_date = report_params.fetch(:end_date, '').to_date || Date.today
          @base_scope = Ahoy::Visit.where(started_at: @start_date..@end_date)
          conditions = {}
          conditions[:utm_campaign] = @utm_campaign if present_and_not_empty(@utm_campaign)
          conditions[:utm_medium] = @utm_medium if present_and_not_empty(@utm_medium)
          conditions[:utm_source] = @utm_source if present_and_not_empty(@utm_source)

          @report_title = "Visit Report for #{@start_date} - #{@end_date}"
          @visits = @base_scope.where(conditions)
        end

        @scoped_events = Ahoy::Event.where(visit: @visits)

        if params[:as_pdf]
          RailsPDF.template("report/chart.html.haml").locals(visits: @visits, report_title: @report_title, scoped_events: @scoped_events).render do |data|
            send_data(data, type: 'application/pdf', disposition: 'inline', filename: "visit_report.pdf")
          end
        end
      end

      private
        def report_params
          params.fetch(:report, {}).permit(:start_date, :end_date, :campaign, :as_pdf,
            :utm_source => [], :utm_medium => [], :utm_campaign => [])
        end

        def present_and_not_empty(arg)
          if arg.present?
            return arg.reject(&:empty?).present? 
          end
          false
        end
    end
  end
end