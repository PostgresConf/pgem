class AddActivitiesToSplashpage < ActiveRecord::Migration
  def change
    add_column :splashpages, :include_activities, :boolean, default: false
  end
end
