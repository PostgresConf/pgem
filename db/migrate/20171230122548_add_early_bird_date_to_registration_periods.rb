class AddEarlyBirdDateToRegistrationPeriods < ActiveRecord::Migration
  def self.up
    add_column :registration_periods, :early_bird_date, :date
  end

  def self.down
    remove_column :registration_periods, :early_bird_date
  end
end
