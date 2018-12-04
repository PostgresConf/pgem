class AddItineraryReqToConference < ActiveRecord::Migration
  def change
    add_column :conferences, :require_itinerary, :boolean
  end
end
