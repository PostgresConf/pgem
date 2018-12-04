class PollsController < ApplicationController
  load_and_authorize_resource :conference, find_by: :short_title
  load_resource :poll, through: :conference, singleton: true
  load_resource :survey, through: :poll, singleton: true

  def show
    @survey = @poll.survey
  end

  def new
    @participant = current_or_guest_user
    @survey = Survey::Survey.find_by(@poll.survey_id)

    @attempt = @survey.attempts.new
    @attempt.answers.build
  end

  private

  def params_whitelist
    if params[:survey_attempt]
      params[:survey_attempt][:answers_attributes] = params[:survey_attempt][:answers_attributes].map { |attrs| { question_id: attrs.first, option_id: attrs.last } }
      params.require(:survey_attempt).permit(Survey::Attempt::AccessibleAttributes)
    end
  end

end
