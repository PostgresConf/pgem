class AddShortNameToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :short_name, :string

    add_index :sponsors, [:short_name], :unique => true
  end
end
