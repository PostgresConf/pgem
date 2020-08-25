class AddStartDateToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :started_at, :Date
  end
end
