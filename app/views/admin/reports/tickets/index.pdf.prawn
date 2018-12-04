prawn_document(force_download: true, filename: "tickets.pdf", page_layout: :landscape) do |pdf|
  obj_array = []
  header_array = ['Purchase Date', 'Ticket', 'Buyer', 'Attendee', 'Purchase Price']
  obj_array << header_array
  @physical_tickets.each do |pt|
    row = []
    row << pt.created_at.strftime("%b %d, %Y")
    row << pt.ticket.title
    row << pt.ticket_purchase.user.name
    row << pt.user.name
    row << humanized_money_with_symbol(pt.ticket_purchase.purchase_price)
    obj_array << row
  end

  pdf.text "Tickets for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table obj_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
