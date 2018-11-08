class AddTicketTypeToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :ticket_type, :integer, default: 0
    add_column :tickets, :start_date, :date
    add_column :tickets, :end_date, :date
  end

  def self.down
    remove_column :tickets, :ticket_type
    remove_column :tickets, :start_date
    remove_column :tickets, :end_date
  end
end
