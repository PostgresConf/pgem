module Portal
  class SponsorsController < Portal::BaseController
    load_and_authorize_resource :sponsor, find_by: :short_name
    load_resource :sponsorship_level
    load_resource :sponsorship_levels_benefits, through: :sponsorship_level

    before_action :authenticate_user!
    before_action :check_user_privs, except: [:index]

    def index
      redirect_to portal_sponsor_path(current_user.sponsor.short_name)
    end

    def show
      @upcoming_sponsorships = @sponsor.upcoming_sponsorships
      @events = @sponsor.sponsorship_events
    end

    def update
      if @sponsor.update_attributes(sponsor_params)
        redirect_to portal_sponsor_path(current_user.sponsor.short_name),
                notice: 'Details successfully updated.'
      else
        flash[:error] = "Update failed: #{@sponsor.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    private

    def sponsor_params
      params.require(:sponsor).permit(:name, :description, :website_url, :picture, :picture_cache)
    end
  end
end
