class CreateConferenceTeamMembers < ActiveRecord::Migration
  def self.up
    create_table :conference_team_members do |t|
      t.references :conference, null: false
      t.references :refinery_team_member, null: false
      t.integer :position, null: false
    end

    add_index :conference_team_members, :conference_id

    add_foreign_key :conference_team_members, :conferences
    add_foreign_key :conference_team_members, :refinery_team_members
  end

  def self.down
    drop_table :conference_team_members
  end

end
