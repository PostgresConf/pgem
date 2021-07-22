class RemoveTileFontColorFromConference < ActiveRecord::Migration
  def change
    remove_column :conferences, :tile_font_color, :string
  end
end
