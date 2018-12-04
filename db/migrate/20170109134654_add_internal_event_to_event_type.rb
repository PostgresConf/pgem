class AddInternalEventToEventType < ActiveRecord::Migration
  def change
    add_column :event_types, :internal_event, :boolean, default: false
  end
end
