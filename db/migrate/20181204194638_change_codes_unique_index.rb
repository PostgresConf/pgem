class ChangeCodesUniqueIndex < ActiveRecord::Migration
  def change
    remove_index :codes, :name
    remove_index :codes, :conference_id
    add_index :codes, [:conference_id, :name], unique: true
  end
end
