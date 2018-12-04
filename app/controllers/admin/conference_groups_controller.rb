module Admin
  class ConferenceGroupsController < Admin::BaseController
    load_and_authorize_resource

    def index
      authorize! :index, ConferenceGroup.new
    end

    def edit
    end

    def create
      if @conference_group.save
        redirect_to admin_conference_groups_path,
                    notice: 'Conference Group successfully created.'
      else
        flash[:error] = "Creating Conference Group failed: #{@conference_group.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @conference_group.update_attributes(conference_group_params)
        redirect_to admin_conference_groups_path_path,
                    notice: 'Conference Group successfully updated.'
      else
        flash[:error] = "Update Conference Group failed: #{@conference_group.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @conference_group.destroy
        redirect_to admin_conference_groups_path,
                    notice: 'Conference Group successfully deleted.'
      else
        redirect_to admin_conference_groups_path,
                    error: 'Deleting Conference Group failed! ' \
                    "#{@conference_group.errors.full_messages.join('. ')}."
      end
    end

    private

    def conference_group_params
      params.require(:conference_group).permit(:name)
    end
  end
end
