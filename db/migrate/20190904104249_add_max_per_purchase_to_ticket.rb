class AddMaxPerPurchaseToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :max_per_purchase, :integer, default: 10
  end
end
