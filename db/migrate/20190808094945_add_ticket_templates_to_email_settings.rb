class AddTicketTemplatesToEmailSettings < ActiveRecord::Migration
  def change
    add_column :email_settings, :purchase_confirmation_subject, :string
    add_column :email_settings, :purchase_confirmation_body, :text
    add_column :email_settings, :ticket_confirmation_subject, :string
    add_column :email_settings, :ticket_confirmation_body, :text
    add_column :email_settings, :assign_ticket_subject, :string
    add_column :email_settings, :assign_ticket_body, :text
    add_column :email_settings, :pending_assign_ticket_subject, :string
    add_column :email_settings, :pending_assign_ticket_body, :text
  end
end
