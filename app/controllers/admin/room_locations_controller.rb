module Admin
  class RoomLocationsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :venue, through: :conference, singleton: true
    load_and_authorize_resource through: :venue

    def index; end

    def edit; end

    def new
      @room_location = @venue.room_locations.new
    end

    def create
      @room_location = @venue.room_locations.new(room_location_params)
      if @room_location.save
        redirect_to admin_conference_venue_room_locations_path(conference_id: @conference.short_title),
                    notice: 'Room Location successfully created.'
      else
        flash.now[:error] = "Creating Room Location failed: #{@room_location.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @room_location.update(room_location_params)
        redirect_to admin_conference_venue_room_locations_path(conference_id: @conference.short_title),
                    notice: 'Room Location successfully updated.'
      else
        flash.now[:error] = "Update Room Location failed: #{@room_location.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @room_location.destroy
        redirect_to admin_conference_venue_room_locations_path(conference_id: @conference.short_title),
                    notice: 'Room Location successfully deleted.'
      else
        redirect_to admin_conference_venue_room_locations_path(conference_id: @conference.short_title),
                    error: "Destroying room location failed! #{@room_location.errors.full_messages.join('. ')}."
      end
    end

    private

    def room_location_params
      params.require(:room_location).permit(:description)
    end
  end
end
