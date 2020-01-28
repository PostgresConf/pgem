# This migration comes from refinery_meetups (originally 1)
class CreateMeetupsMeetups < ActiveRecord::Migration

  def up
    create_table :refinery_meetups do |t|
      t.string :external_id
      t.string :title
      t.text :description
      t.string :url
      t.string :picture_url
      t.datetime :start
      t.datetime :end
      t.string :location
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-meetups"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/meetups/meetups"})
    end

    drop_table :refinery_meetups

  end

end
