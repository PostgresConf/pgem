class AddEventId < ActiveRecord::Migration
  def change
    add_reference :ticket_purchases, :event

    add_index :ticket_purchases, [:event_id]

    add_foreign_key :ticket_purchases, :events
  end
end
