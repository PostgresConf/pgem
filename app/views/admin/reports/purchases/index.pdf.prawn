prawn_document(force_download: true, filename: "ticket_purchases.pdf", page_layout: :landscape) do |pdf|
  obj_array = []
  header_array = ['Purchase Date', 'Ticket', 'Qty','Buyer', 'Purchase Total', 'Code Used', 'Paid?']
  obj_array << header_array
  @purchases.each do |pur|
    row = []
    row << pur.created_at.strftime("%b %d, %Y")
    row << pur.title
    row << pur.quantity
    row << pur.user.name
    row << humanized_money_with_symbol(pur.purchase_price*pur.quantity)
    row << "#{pur.code.present? ? pur.code.name : ''}"
    row << "#{pur.paid? ? 'Yes' : 'No'}"

    obj_array << row
  end

  pdf.text "Ticket Purchases for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table obj_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
