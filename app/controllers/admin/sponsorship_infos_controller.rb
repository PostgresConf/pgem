module Admin
  class SponsorshipInfosController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, singleton: true

    def show; end

    def edit; end

    def create
      @sponsorship_info = @conference.build_sponsorship_info(sponsorship_info_params)

      if @sponsorship_info.save
        redirect_to admin_conference_sponsorship_info_path,
                    notice: 'Sponsorship Info was successfully created.'
      else
        render :new
      end
    end

    def update
      if @sponsorship_info.update_attributes(sponsorship_info_params)
        redirect_to admin_conference_sponsorship_info_path(conference_id: @conference.short_title),
                    notice: 'Sponsorship Info was successfully updated.'
      else
        flash.now[:error] = "Update Sponsorship Info failed: #{@sponsorship_info.errors.full_messages.join('. ')}."
        render :edit
      end
    end


    private

    def sponsorship_info_params
      params.require(:sponsorship_info).permit(:description, :prospectus, :liaison_email, :manual)
    end
  end
end
