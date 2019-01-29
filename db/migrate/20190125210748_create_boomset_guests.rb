class CreateBoomsetGuests < ActiveRecord::Migration
  def self.up
    create_table :boomset_guests do |t|
      t.belongs_to :conference
      t.belongs_to :integration
      t.belongs_to :registration
      t.integer :boomset_guest
      t.string  :token
      t.timestamps
    end

    add_foreign_key :boomset_guests, :conferences
    add_foreign_key :boomset_guests, :integrations
    add_foreign_key :boomset_guests, :registrations

    add_index :boomset_guests, [:conference_id, :registration_id], unique: true
    add_index :boomset_guests, [:conference_id, :boomset_guest]
    add_index :boomset_guests, [:conference_id, :token]
  end

  def self.down
    drop_table :boomset_guests
  end
end
