class AddRegReminderEndToCfp < ActiveRecord::Migration
  def change
    add_column :cfps, :reg_reminder_end, :date
  end
end
