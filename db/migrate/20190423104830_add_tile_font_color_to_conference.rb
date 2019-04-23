class AddTileFontColorToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :tile_font_color, :string, :default => "#ffffff"
  end
end
