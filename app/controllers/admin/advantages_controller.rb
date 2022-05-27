module Admin
  class AdvantagesController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :advantage, through: :conference

    def index
    end

    def new
      @advantage = @conference.advantages.new
    end

    def create
      @advantage = @conference.advantages.new(advantage_params)
      if @advantage.save
        redirect_to admin_conference_advantages_path(conference_id: @conference.short_title),
                    notice: 'Advantage successfully created.'
      else
        flash[:error] = "Creating Advantage failed: #{@advantage.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def edit; end

    def update
      if @advantage.update(advantage_params)
        redirect_to admin_conference_advantages_path(conference_id: @conference.short_title),
                    notice: 'Advantage successfully updated.'
      else
        flash[:error] = "Update Advantage failed: #{@advantage.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @advantage.destroy
        redirect_to admin_conference_advantages_path(conference_id: @conference.short_title),
                    notice: 'Advantage successfully deleted.'
      else
        redirect_to admin_conference_advantages_path(conference_id: @conference.short_title),
                    error: 'Deleting advantage failed.' \
                    "#{@advantage.errors.full_messages.join('. ')}."
      end
    end

    private

    def advantage_params
      params.require(:advantage).permit(:name, :description, :picture, :picture_cache, :conference_id)
    end
  end
end
