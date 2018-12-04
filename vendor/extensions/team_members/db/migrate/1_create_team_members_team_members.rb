class CreateTeamMembersTeamMembers < ActiveRecord::Migration

  def up
    create_table :refinery_team_members do |t|
      t.string :firstname
      t.string :middlename
      t.string :lastname
      t.string :role
      t.integer :photo_id
      t.text :description
      t.string :twitter
      t.string :linkedin
      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-team_members"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/team_members/team_members"})
    end

    drop_table :refinery_team_members

  end

end
