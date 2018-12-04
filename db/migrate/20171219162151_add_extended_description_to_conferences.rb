class AddExtendedDescriptionToConferences < ActiveRecord::Migration
  def change
    add_column :conferences, :extended_description, :text
  end
end
