module Admin
  class ActivitiesController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :activity, through: :conference

    def index
    end

    def new
      @activity = @conference.activities.new
    end

    def create
      @activity = @conference.activities.new(activity_params)
      if @activity.save
        redirect_to admin_conference_activities_path(conference_id: @conference.short_title),
                    notice: 'Activity successfully created.'
      else
        flash[:error] = "Creating Activity failed: #{@activity.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def edit; end

    def update
      if @activity.update_attributes(activity_params)
        redirect_to admin_conference_activities_path(conference_id: @conference.short_title),
                    notice: 'Activity successfully updated.'
      else
        flash[:error] = "Update Activity failed: #{@activity.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @activity.destroy
        redirect_to admin_conference_activities_path(conference_id: @conference.short_title),
                    notice: 'Activity successfully deleted.'
      else
        redirect_to admin_conference_activities_path(conference_id: @conference.short_title),
                    error: 'Deleting activity failed.' \
                    "#{@activity.errors.full_messages.join('. ')}."
      end
    end

    private

    def activity_params
      params.require(:activity).permit(:name, :description, :picture, :picture_cache, :website_link, :conference_id)
    end
  end
end
