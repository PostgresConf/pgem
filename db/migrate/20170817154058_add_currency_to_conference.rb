class AddCurrencyToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :default_currency, :string, default: 'USD'
    add_column :conferences, :braintree_merchant_account, :string
  end
end
