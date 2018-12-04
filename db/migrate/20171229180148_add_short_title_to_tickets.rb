class AddShortTitleToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :short_title, :string
  end

  def self.down
    remove_column :tickets, :short_title
  end
end
