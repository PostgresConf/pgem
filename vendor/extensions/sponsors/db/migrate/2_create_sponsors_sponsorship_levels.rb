class CreateSponsorsSponsorshipLevels < ActiveRecord::Migration

  def up
    create_table :refinery_sponsors_sponsorship_levels do |t|
      t.string :name
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sponsors"})
    end

    drop_table :refinery_sponsors_sponsorship_levels

  end

end
