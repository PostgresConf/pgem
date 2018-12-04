prawn_document(force_download: true, filename: "codes.pdf", page_layout: :landscape) do |pdf|
  obj_array = []
  header_array = ['Name', 'Uses', 'Type', 'Sponsor']
  obj_array << header_array
  @codes.each do |code|
    if code.sponsor.blank?
      sponsor = ''
    else
      sponsor = code.sponsor.name
    end

    row = []
    row << code.name
    row << TicketPurchase.get_code_usage(@conference, code)
    row << code.code_type.title
    row << sponsor
    obj_array << row
  end

  pdf.text "Code Usage for #{@conference.short_title}", font_size: 25, align: :center
  pdf.table obj_array, header: true, cell_style: {size: 8, border_width: 1}, position: :center
end
