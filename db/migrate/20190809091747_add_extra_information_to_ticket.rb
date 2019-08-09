class AddExtraInformationToTicket < ActiveRecord::Migration
  def change
    add_column :tickets, :extra_info, :text
  end
end
