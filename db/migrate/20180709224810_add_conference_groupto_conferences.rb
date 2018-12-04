class AddConferenceGrouptoConferences < ActiveRecord::Migration
  def self.up
    add_reference :conferences, :conference_group, foreign_key: true
  end

  def self.down
    remove_foreign_key :conferences, :conference_groups
    remove_reference :conferences, :conference_group
  end
end
