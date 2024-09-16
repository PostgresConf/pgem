class AddNotificationDeadlineToCfp < ActiveRecord::Migration
  def change
    add_column :cfps, :notification_deadline, :date
  end
end
