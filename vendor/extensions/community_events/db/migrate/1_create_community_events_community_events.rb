class CreateCommunityEventsCommunityEvents < ActiveRecord::Migration

  def up
    create_table :refinery_community_events do |t|
      t.string :title
      t.text :body
      t.string :url
      t.datetime :published_at
      t.string :author
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-community_events"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/community_events/community_events"})
    end

    drop_table :refinery_community_events

  end

end
