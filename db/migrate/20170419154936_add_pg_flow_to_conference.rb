class AddPgFlowToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :use_pg_flow, :boolean, default: true
  end
end
