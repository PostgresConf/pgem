class CreateCodesTickets < ActiveRecord::Migration
  def self.up
    create_table :codes_tickets, id: false do |t|
      t.references :code
      t.references :ticket
    end

    add_index :codes_tickets, [:code_id, :ticket_id], :unique => true

    add_foreign_key :codes_tickets, :codes
    add_foreign_key :codes_tickets, :tickets
  end

  def self.down
    drop_table :codes_tickets
  end
end
