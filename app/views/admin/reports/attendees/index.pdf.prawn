prawn_document(force_download: true, filename: "attendees.pdf", page_layout: :landscape) do |pdf|
  attendees_array = []
  header_array = ['Last Name', 'First Name', 'Affiliation', 'Job Title', 'Email', 'Type']
  attendees_array << header_array
  @attendees.each do |attendee|
    row = []
    row << attendee.last_name
    row << attendee.first_name
    row << (attendee.affiliation.present? ? attendee.affiliation : '')
    row << (attendee.title.present? ? attendee.title : '')
    row << attendee.email
    row << attendee.type
    attendees_array << row
  end

  pdf.text "Attendees for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table attendees_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
