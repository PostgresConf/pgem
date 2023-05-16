class ReceiptPdf < InvoicePrinter::Document
  include MoneyRails::ActionViewExtension
  def initialize(conference, user, payment, lines)

    InvoicePrinter.labels = {
      name: conference.title,
      payment_by_transfer: 'Paid by the account below:',
      due_date: 'Paid date',
      tax3: 'Discount',
    }

    items = []
    lines.each do |line|
      if line.code_id.present?
        discount = Code.get_discount(line.code_id, line.ticket_id)
      end

      items << InvoicePrinter::Document::Item.new(
        name: line.title,
        quantity: line.quantity,
        price: humanized_money_with_symbol(line.price),
        tax3: discount,
        amount: humanized_money_with_symbol(line.total_purchase_price)
      )
    end

    super(
      number: "Receipt: #{payment.id}",
      provider_name: conference.contact.name,
      provider_street: conference.contact.street1,
      provider_postcode: conference.contact.street2,
      provider_extra_address_line: "#{conference.contact.city}, #{conference.contact.state} #{conference.contact.postal_code} #{conference.contact.country}",
      purchaser_name: user.name,
      due_date: payment.created_at.strftime("%B %d, %Y"),
      total: humanized_money_with_symbol(payment.amount_as_money),
      bank_account_number: payment.masked_card_no,
      items: items)
  end
end
