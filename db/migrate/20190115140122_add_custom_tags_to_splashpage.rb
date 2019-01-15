class AddCustomTagsToSplashpage < ActiveRecord::Migration
  def change
    add_column :splashpages, :custom_tags, :text
  end
end
