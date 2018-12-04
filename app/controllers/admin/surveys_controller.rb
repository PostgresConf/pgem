module Admin
  class SurveysController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :poll, through: :conference, singleton: true
    load_and_authorize_resource :survey, through: :poll, singleton: true

    def show
    end

    def update
      if @survey.update_attributes(survey_params)
        redirect_to admin_conference_poll_path(
                    conference_id: @conference.short_title),
                    notice: 'Survey successfully updated.'
      else
        flash.now[:error] = "Update Survey failed: #{@poll.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    private

    def survey_params
      params.require(:survey_survey).permit(Survey::Survey::AccessibleAttributes)
    end

  end
end
