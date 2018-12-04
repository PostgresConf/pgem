module Admin
  class SponsorsController < Admin::BaseController
    load_and_authorize_resource

    def index
      authorize! :index, Sponsor.new
    end

    def edit
      @users = User.order(:first_name, :last_name) 
    end

    def create
      if @sponsor.save
        redirect_to admin_sponsors_path,
                    notice: 'Sponsor successfully created.'
      else
        flash[:error] = "Creating sponsor failed: #{@sponsor.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @sponsor.update_attributes(sponsor_params)
        redirect_to admin_sponsors_path,
                    notice: 'Sponsor successfully updated.'
      else
        flash[:error] = "Update sponsor failed: #{@sponsor.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @sponsor.destroy
        redirect_to admin_sponsors_path,
                    notice: 'Sponsor successfully deleted.'
      else
        redirect_to admin_sponsors_path,
                    error: 'Deleting sponsor failed! ' \
                    "#{@sponsor.errors.full_messages.join('. ')}."
      end
    end

    private

    def sponsor_params
      params.require(:sponsor).permit(:name, :description, :website_url, :picture, :picture_cache, :short_name, :user_ids => [])
    end
  end
end
