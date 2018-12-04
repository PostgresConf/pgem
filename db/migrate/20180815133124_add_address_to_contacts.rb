class AddAddressToContacts < ActiveRecord::Migration
  def self.up
    add_column :contacts, :name, :string
    add_column :contacts, :street1, :string
    add_column :contacts, :street2, :string
    add_column :contacts, :city, :string
    add_column :contacts, :state, :string
    add_column :contacts, :country, :string
    add_column :contacts, :postal_code, :string
  end

  def self.down
    remove_column :contacts, :name
    remove_column :contacts, :street1
    remove_column :contacts, :street2
    remove_column :contacts, :city
    remove_column :contacts, :state
    remove_column :contacts, :country
    remove_column :contacts, :postal_code
  end
end
