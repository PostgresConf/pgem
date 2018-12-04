module Portal
  class ConferencesController < Portal::BaseController
    load_and_authorize_resource :sponsor, find_by: :short_name
    load_and_authorize_resource :conference, find_by: :short_title

    before_action :check_user_privs

    def index
    end

    def show
      # Line charts
      @registrations = {@conference.short_title => @conference.get_registrations_per_week}
      @registration_weeks = [0]
      @registration_weeks.push(@registrations[@conference.short_title].length)

      @registration_weeks = @registration_weeks.max
      @registrations = normalize_array_length(@registrations, @registration_weeks)
      @registration_weeks = @registration_weeks > 0 ? (1..@registration_weeks).to_a : 1

      @sponsorship = Sponsorship.find_sponsorship(@conference, @sponsor)
      @sponsorship_progress = @sponsorship.calculate_progress
      @sponsorship_items = @sponsorship.progress_status

      @promo_codes = Code.sponsor_codes(@conference, @sponsor)
    end

    def update
    end

  end
end
