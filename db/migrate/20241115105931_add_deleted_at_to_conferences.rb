class AddDeletedAtToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :deleted_at, :datetime
    add_index :conferences, :deleted_at
  end
end
