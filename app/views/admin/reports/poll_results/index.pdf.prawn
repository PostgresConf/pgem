prawn_document(force_download: true, filename: "poll_results.pdf", page_layout: :landscape) do |pdf|
  result_array = []
  header_array = ['Question',
                  'Answer1',
                  'Answer1 Result',
                  'Answer2',
                  'Answer2 Result',
                  'Answer3',
                  'Answer3 Result',
                  'Answer4',
                  'Answer4 Result',
                  'Answer5',
                  'Answer5 Result']
  result_array << header_array
  @poll_results.each do |result|
    row = []
    row << PollResult.option_text(result.answer1)
    row << PollResult.option_result(result.survey_question_id, result.answer1)
    row << PollResult.option_text(result.answer2)
    row << PollResult.option_result(result.survey_question_id, result.answer2)
    row << PollResult.option_text(result.answer3)
    row << PollResult.option_result(result.survey_question_id, result.answer3)
    row << PollResult.option_text(result.answer4)
    row << PollResult.option_result(result.survey_question_id, result.answer4)
    row << PollResult.option_text(result.answer5)
    row << PollResult.option_result(result.survey_question_id, result.answer5)
    result_array << row
  end

  pdf.text "Poll Results for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table result_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
