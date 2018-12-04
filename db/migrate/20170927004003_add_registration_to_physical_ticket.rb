class AddRegistrationToPhysicalTicket < ActiveRecord::Migration
  def change
    add_reference :physical_tickets, :user, null: false, index: true
    add_reference :physical_tickets, :event
    add_reference :physical_tickets, :registration, null: false, index: true
    add_column :physical_tickets, :pending_assignment, :string

    add_foreign_key :physical_tickets, :users
    add_foreign_key :physical_tickets, :events
    add_foreign_key :physical_tickets, :registrations

    execute "CREATE INDEX pending_ticket_assignment_idx ON physical_tickets (lower(pending_assignment)) WHERE pending_assignment IS NOT NULL;"
  end
end
