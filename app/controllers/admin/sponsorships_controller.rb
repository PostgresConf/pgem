module Admin
  class SponsorshipsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :sponsorship, through: :conference
    before_action :sponsorship_level_required, only: [:index, :new]

    def index
      authorize! :index, Sponsorship.new(conference_id: @conference.id)
    end

    def edit; end

    def new
      @sponsorship = @conference.sponsorships.new
    end

    def create
      @sponsorship = @conference.sponsorships.new(sponsorship_params)
      if Sponsorship.create_sponsorship(@sponsorship)
        redirect_to admin_conference_sponsorships_path(conference_id: @conference.short_title),
                    notice: 'Sponsorship successfully created.'
      else
        flash[:error] = "Creating sponsorship failed: #{@sponsorship.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @sponsorship.update_attributes(sponsorship_params)
        redirect_to admin_conference_sponsorships_path(
                    conference_id: @conference.short_title),
                    notice: 'Sponsorship successfully updated.'
      else
        flash[:error] = "Update sponsorship failed: #{@sponsorship.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @sponsorship.destroy
        redirect_to admin_conference_sponsorships_path(conference_id: @conference.short_title),
                    notice: 'Sponsorship successfully deleted.'
      else
        redirect_to admin_conference_sponsorships_path(conference_id: @conference.short_title),
                    error: 'Deleting sponsorship failed! ' \
                    "#{@sponsorship.errors.full_messages.join('. ')}."
      end
    end

    private

    def sponsorship_params
      params.require(:sponsorship).permit(:sponsor_id, :sponsorship_level_id, :conference_id)
    end

    def sponsorship_level_required
      return unless @conference.sponsorship_levels.empty?
      redirect_to admin_conference_sponsorship_levels_path(conference_id: @conference.short_title),
                  alert: 'You need to create atleast one sponsorship level to add a sponsorship'
    end
  end
end
