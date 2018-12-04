class AddBackgroundImageToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :background_file_name, :string
  end
end
