class CreateRoomLocations < ActiveRecord::Migration
  def self.up
    create_table :room_locations do |t|
      t.belongs_to :venue
      t.string :description
      t.timestamps
    end

    add_foreign_key :room_locations, :venues

    add_index :room_locations, [:venue_id]
  end

  def self.down
    drop_table :room_locations
  end
end
