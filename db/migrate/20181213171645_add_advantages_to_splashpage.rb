class AddAdvantagesToSplashpage < ActiveRecord::Migration
  def change
    add_column :splashpages, :include_advantages, :boolean, default: false
  end
end
