class AddConferenceIdToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :conference_id, :integer
  end
end
