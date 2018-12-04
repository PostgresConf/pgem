class CreateConferenceGroups < ActiveRecord::Migration
  def self.up
    create_table :conference_groups do |t|
      t.string :name, null: false

      t.timestamps
    end

  end

  def self.down
    drop_table :conference_groups
  end
end
