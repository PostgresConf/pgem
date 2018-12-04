class AddIsHighlightToEventUsers < ActiveRecord::Migration
  def self.up
    add_column :event_users, :is_highlight, :boolean, default: false
  end

  def self.down
    remove_column :event_users, :is_highlight
  end
end
