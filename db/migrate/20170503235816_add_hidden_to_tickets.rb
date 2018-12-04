class AddHiddenToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :hidden, :boolean, default: false
  end
end
