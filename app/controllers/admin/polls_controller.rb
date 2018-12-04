module Admin
  class PollsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :poll, through: :conference, singleton: true

    def create
      @survey = Survey::Survey.create({:name => @conference.short_title, :description => @conference.title})
      @poll.survey = @survey

      if @poll.save
        redirect_to admin_conference_poll_path(@conference.short_title),
                    notice: 'Poll was successfully created.'
      else
        redirect_to admin_conference_poll_path(conference_id: @conference.short_title),
                    error: "Could not create poll. #{@poll.errors.full_messages.join('. ')}."
      end
    end

    def show
    end

    def destroy
      @survey = @poll.survey

      if @poll.destroy
        @survey.destroy
        redirect_to admin_conference_poll_path(conference_id: @conference.short_title),
                    notice: 'Poll successfully deleted.'
      else
        redirect_to admin_conference_poll_path(conference_id: @conference.short_title),
                    error: "Poll couldn't be deleted. #{@poll.errors.full_messages.join('. ')}."
      end
    end

    def update
      if @poll.update_attributes(poll_params)
        redirect_to admin_conference_poll_path(
                    conference_id: @conference.short_title),
                    notice: 'Poll successfully updated.'
      else
        flash.now[:error] = "Update Poll failed: #{@poll.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    private

    def poll_params
      params.permit(:poll, :comment)
    end

  end
end
