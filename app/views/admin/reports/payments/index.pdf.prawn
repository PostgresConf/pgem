prawn_document(force_download: true, filename: "payments.pdf", page_layout: :landscape) do |pdf|
  obj_array = []
  header_array = ['Purchase Date', 'Buyer', 'Last 4', 'Amount']
  obj_array << header_array
  @payments.each do |payment|
    row = []
    row << payment.created_at.strftime("%b %d, %Y")
    row << payment.user.name
    row << payment.last4
    row << humanized_money_with_symbol(payment.amount_as_money)
    obj_array << row
  end

  pdf.text "Payments for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table obj_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
