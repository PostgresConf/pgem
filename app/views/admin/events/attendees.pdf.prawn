prawn_document(force_download: true, filename: "#{@file_name}.pdf", page_layout: :landscape) do |pdf|
  attendees_array = []
  header_array = ['User', 'First Name', 'Last Name', 'Email', 'Affiliation', 'Job Title', 'Conference']
  attendees_array << header_array
  @attendees.each do |attendee|
    row = []
    row << attendee.id
    row << attendee.first_name
    row << attendee.last_name
    row << attendee.email
    row << (attendee.affiliation.present? ? attendee.affiliation : '')
    row << (attendee.title.present? ? attendee.title : '')
    row << @event.program.conference.short_title
    attendees_array << row
  end

  pdf.text "Attendees for #{@event.title}", font_size: 25, align: :center
  pdf.table attendees_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
