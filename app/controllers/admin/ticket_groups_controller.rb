module Admin
  class TicketGroupsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, except: [:new, :create]

    def index; end

    def show
    end

    def new
       @ticket_group = TicketGroup.new(conference_id: @conference.id)
       authorize! :create, @ticket_group
    end

    def create
      @ticket_group = @conference.ticket_groups.new(ticket_group_params)
      @ticket_group.conference_id = @conference.id
      authorize! :create, @ticket_group

      if @conference.save
        redirect_to admin_conference_ticket_groups_path, notice: 'Ticker Group was successfully created.'
      else
        flash.now[:error] = "Oops, couldn't save Ticket Group. #{@code.errors.full_messages.join('. ')}"
        render :new
      end
    end

    # PUT ticket_groups/1
    def update
      if @ticket_group.update_attributes(ticket_group_params)
        redirect_to admin_conference_ticket_groups_path(conference_id: @conference.short_title), notice: "Ticket Group '#{@ticket_group.name}' for #{@conference.short_title} successfully updated."
      else
        flash.now[:error] = "Update of Ticket Group for #{@conference.short_title} failed. #{@code.errors.full_messages.join('. ')}"
        render :edit
      end
    end

    def destroy
      @ticket_group.destroy
      redirect_to admin_conference_ticket_groups_path(conference_id: @conference.short_title), notice: 'Ticket Group was successfully destroyed.'
    end

    # Update ticket_groups used for the conference
    def update_conference
      authorize! :update, TicketGroup.new(conference_id: @conference.id)
      if @conference.update_attributes(conference_params)
        redirect_to admin_conference_ticket_groups_path(conference_id: @conference.short_title), notice: "Ticket Groups for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_ticket_groups_path(conference_id: @conference.short_title), notice: "Update of Ticket Groups for #{@conference.short_title} failed."
      end
    end

    def up
      @ticket_group.move_higher
      redirect_to admin_conference_ticket_groups_path(conference_id: @conference.short_title)
    end

    def down
      @ticket_group.move_lower
      redirect_to admin_conference_ticket_groups_path(conference_id: @conference.short_title)
    end


    private

    def ticket_group_params
      params.require(:ticket_group).permit(:name, :description, :position, :additional_details, :conference_id)
    end

    def conference_params
      params.require(:conference).permit(ticket_group_ids: [])
    end
  end
end
