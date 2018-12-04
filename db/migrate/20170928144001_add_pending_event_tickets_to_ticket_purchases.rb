class AddPendingEventTicketsToTicketPurchases < ActiveRecord::Migration
  def change
    add_column :ticket_purchases, :pending_event_tickets, :string
  end
end
