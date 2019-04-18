class AddTileImagesToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :tile_background_file_name, :string
  end
end
