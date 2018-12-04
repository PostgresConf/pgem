class AddPositionToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :position, :integer
  end
end
