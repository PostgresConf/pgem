class RemoveTileBackgroundImageFromConference < ActiveRecord::Migration
  def change
    remove_column :conferences, :tile_background_file_name, :string
  end
end
