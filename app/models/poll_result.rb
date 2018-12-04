class PollResult < ActiveRecord::Base
  belongs_to :survey_question, :class_name => Survey::Question

  delegate :text, to: :survey_question

  def self.option_text(option_id)
    unless option_id.blank?
      option = Survey::Option.find_by(id: option_id)
      option.text
    end
  end

  def self.option_result(question_id, option_id)
    Survey::Answer.where(question_id: question_id, option_id: option_id).count
  end
end
