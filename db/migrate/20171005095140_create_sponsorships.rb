class CreateSponsorships < ActiveRecord::Migration
  def self.up
    create_table :sponsorships do |t|
      t.references :conference, null: false
      t.references :sponsor, null: false
      t.references :sponsorship_level
      t.timestamps
    end

    add_foreign_key :sponsorships, :conferences
    add_foreign_key :sponsorships, :sponsors
    add_foreign_key :sponsorships, :sponsorship_levels

    add_index :sponsorships, [:conference_id, :sponsor_id], :unique => true
  end

  def self.down
    drop_table :sponsorships
  end
end
