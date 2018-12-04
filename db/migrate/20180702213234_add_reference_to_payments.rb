class AddReferenceToPayments < ActiveRecord::Migration
  def self.up
    add_column :payments, :reference, :string

    add_index :payments, :reference, unique: true
  end

  def self.down
    remove_column :payments, :reference
  end
end
