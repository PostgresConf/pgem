class CreateSponsorsUsers < ActiveRecord::Migration
  def self.up
    create_table :sponsors_users, id: false do |t|
      t.references :sponsor
      t.references :user
    end

    add_index :sponsors_users, [:user_id], :unique => true

    add_foreign_key :sponsors_users, :sponsors
    add_foreign_key :sponsors_users, :users
  end

  def self.down
    drop_table :sponsors_users
  end
end
