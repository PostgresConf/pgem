class AddPurchasePriceToTicketPurchases < ActiveRecord::Migration
  def change
    add_monetize :ticket_purchases, :purchase_price
  end
end
