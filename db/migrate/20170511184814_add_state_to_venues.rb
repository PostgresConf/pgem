class AddStateToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :state, :string
  end
end
