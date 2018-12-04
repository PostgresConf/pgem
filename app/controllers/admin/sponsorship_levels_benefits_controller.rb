module Admin
  class SponsorshipLevelsBenefitsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :sponsorship_levels_benefit, through: :conference

    def index
    end

    def new
      @sponsorship_levels_benefit = @conference.sponsorship_levels_benefits.new
    end

    def create
      @sponsorship_levels_benefit = @conference.sponsorship_levels_benefits.new(sponsorship_levels_benefit_params)
      if @sponsorship_levels_benefit.save
        redirect_to admin_conference_sponsorship_levels_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully created.'
      else
        flash[:error] = "Creating Benefit failed: #{@sponsorship_levels_benefit.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @sponsorship_levels_benefit.update_attributes(sponsorship_levels_benefit_params)
        redirect_to admin_conference_sponsorship_levels_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully updated.'
      else
        flash[:error] = "Update Benefit failed: #{@sponsorship_levels_benefit.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @sponsorship_levels_benefit.destroy
        redirect_to admin_conference_sponsorship_levels_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully deleted.'
      else
        redirect_to admin_conference_sponsorship_levels_benefits_path(conference_id: @conference.short_title),
                    error: 'Deleting benefit failed.' \
                    "#{@sponsorship_levels_benefit.errors.full_messages.join('. ')}."
      end
    end

    private

    def sponsorship_levels_benefit_params
      params.require(:sponsorship_levels_benefit).permit(:conference_id, :code_type_id, :max_uses, :discount)
    end
  end
end
