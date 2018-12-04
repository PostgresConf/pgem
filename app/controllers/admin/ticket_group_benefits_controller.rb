module Admin
  class TicketGroupBenefitsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :ticket_group_benefit, through: :conference

    def index
    end

    def new
      @ticket_group_benefit = @conference.ticket_group_benefits.new
    end

    def create
      @ticket_group_benefit = @conference.ticket_group_benefits.new(ticket_group_benefit_params)
      if @ticket_group_benefit.save
        redirect_to admin_conference_ticket_group_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully created.'
      else
        flash[:error] = "Creating Benefit failed: #{@ticket_group_benefit.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @ticket_group_benefit.update_attributes(ticket_group_benefit_params)
        redirect_to admin_conference_ticket_group_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully updated.'
      else
        flash[:error] = "Update Benefit failed: #{@ticket_group_benefit.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @ticket_group_benefit.destroy
        redirect_to admin_conference_ticket_group_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully deleted.'
      else
        redirect_to admin_conference_ticket_group_benefits_path(conference_id: @conference.short_title),
                    error: 'Deleting benefit failed.' \
                    "#{@ticket_group_benefit.errors.full_messages.join('. ')}."
      end
    end

    def up
      @ticket_group_benefit.move_higher
      redirect_to admin_conference_ticket_group_benefits_path(conference_id: @conference.short_title)
    end

    def down
      @ticket_group_benefit.move_lower
      redirect_to admin_conference_ticket_group_benefits_path(conference_id: @conference.short_title)
    end

    private

    def ticket_group_benefit_params
      params.require(:ticket_group_benefit).permit(:ticket_group_id, :name, :description, :position, :conference_id)
    end
  end
end
