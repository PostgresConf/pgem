class RemoveColsFromSponsors < ActiveRecord::Migration
  def change
    remove_column :sponsors, :conference_id 
    remove_column :sponsors, :sponsorship_level_id
  end
end
