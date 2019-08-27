class AddSendTicketPdfToEmailSettings < ActiveRecord::Migration
  def change
    add_column :email_settings, :send_ticket_pdf, :boolean, default: true
  end
end
