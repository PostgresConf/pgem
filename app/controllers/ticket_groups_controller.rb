class TicketGroupsController < ApplicationController
  load_and_authorize_resource :conference, find_by: :short_title

  def show
    @primary_group = @conference.ticket_groups.first
    if @primary_group.blank?
      redirect_to conference_tickets_path(@conference.short_title)
    else
      @tickets = Ticket.visible_group_tickets(@conference, @primary_group).limit(4)
    end

    @benefits = @primary_group.ticket_group_benefits
  end


end
