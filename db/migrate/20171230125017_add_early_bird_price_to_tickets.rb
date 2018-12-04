class AddEarlyBirdPriceToTickets < ActiveRecord::Migration
  def self.up
    add_monetize :tickets, :early_bird_price
  end

  def self.down
    remove_monetize :tickets, :early_bird_price
  end
end
