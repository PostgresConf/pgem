# This migration comes from refinery_sponsors (originally 1)
class CreateSponsorsSponsors < ActiveRecord::Migration

  def up
    create_table :refinery_sponsors do |t|
      t.string :name
      t.string :url
      t.integer :logo_id
      t.text :description
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-sponsors"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/sponsors/sponsors"})
    end

    drop_table :refinery_sponsors

  end

end
