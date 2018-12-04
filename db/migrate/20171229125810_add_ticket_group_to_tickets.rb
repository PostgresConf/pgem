class AddTicketGroupToTickets < ActiveRecord::Migration
  def self.up
    add_reference :tickets, :ticket_group, index: true, foreign_key: true
  end

  def self.down
    remove_foreign_key :tickets, :ticket_groups
    remove_reference :tickets, :ticket_group, index: true
  end
end
