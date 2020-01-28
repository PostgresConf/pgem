class AddDigitalToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :digital, :boolean
  end
end
