prawn_document(force_download: true, filename: "duplicate_tickets.pdf", page_layout: :landscape) do |pdf|
  obj_array = []
  header_array = ['Ticket Owner', 'Owner Email', 'Ticket', 'Quantity', 'Pending Assignments']
  obj_array << header_array
  @duplicates.each do |dup|
    row = []
    row << dup.user.name
    row << dup.user.email
    row << dup.ticket.title
    row << dup.ticket_count
    row << dup.pending_assignments
    obj_array << row
  end

  pdf.text "Duplicate Tickets for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table obj_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
