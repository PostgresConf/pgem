module SurveysHelper
  def link_to_remove_field(name, f)
    f.hidden_field(:_destroy) +
    __link_to_function(raw(name), "removeField(this)", :id =>"remove-attach", class: 'btn btn-default')
  end

  def link_to_add_field(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,:child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    __link_to_function(name, "addField(this, \"#{association}\", \"#{escape_javascript(fields)}\")",
    :id=>"add-attach",
    :class=>"btn btn-default")
  end

  def get_answer_fields attempt
    attempt.survey.questions.map { |q| Survey::Answer.new(question_id: q.id) }
  end

  def the_chosen_one? answer, option
    if answer.option_id == option.id then 'chosen' else nil end
  end

  def number_of_people_who_also_answered option_id
    count = number_of_people_who_also_answered_count(option_id)
    "<span class='number'> #{count} </span> #{'answer'.pluralize}".html_safe
  end

  private

  def __link_to_function(name, on_click_event, opts={})
    link_to(name, 'javascript:;', opts.merge(onclick: on_click_event))
  end

  def has_weights? survey
    survey.questions.map(&:options).flatten.any? { |o| o.weight != 0 }
  end

  def get_attempt_questions attempt, imported
    if imported
      attempt.survey.questions.where(imported: imported).order('random()').limit(3)
    else
      attempt.survey.questions.where(imported: imported).order('random()')
    end
  end
end
