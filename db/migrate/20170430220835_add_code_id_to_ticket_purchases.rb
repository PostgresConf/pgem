class AddCodeIdToTicketPurchases < ActiveRecord::Migration
  def change
    add_reference :ticket_purchases, :code

    add_index :ticket_purchases, [:conference_id, :code_id]

    add_foreign_key :ticket_purchases, :codes
  end
end
