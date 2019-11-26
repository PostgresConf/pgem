class AddStickyToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :sticky, :boolean, default: false
  end
end
