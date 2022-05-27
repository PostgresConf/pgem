module Admin
  class BoomsetTicketConfigsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :boomset_ticket_config, through: :conference

    def index
    end

    def new
      @boomset_ticket_config = @conference.boomset_ticket_configs.new
      @integration = BoomsetTicketConfig.get_boomset_integration(@conference)
      @reg_types = BoomsetTicketConfig.get_registration_types(@integration)
    end

    def create
      @boomset_ticket_config = @conference.boomset_ticket_configs.new(boomset_ticket_config_params)
      @integration = BoomsetTicketConfig.get_boomset_integration(@conference)
      @boomset_ticket_config.integration = @integration

      if @boomset_ticket_config.save
        redirect_to admin_conference_boomset_ticket_configs_path(conference_id: @conference.short_title),
                    notice: 'Boomset ticket successfully created.'
      else
        flash[:error] = "Creating Boomset ticket failed: #{@integration.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def edit
        @integration = BoomsetTicketConfig.get_boomset_integration(@conference)
	@reg_types = BoomsetTicketConfig.get_registration_types(@integration)
    end

    def update
      if @boomset_ticket_config.update(boomset_ticket_config_params)
        redirect_to admin_conference_boomset_ticket_configs_path(conference_id: @conference.short_title),
                    notice: 'Boomset ticket successfully updated.'
      else
        flash[:error] = "Update Boomset ticket failed: #{@boomset_ticket_config.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @boomset_ticket_config.destroy
        redirect_to admin_conference_boomset_ticket_configs_path(conference_id: @conference.short_title),
                    notice: 'Boomset ticket successfully deleted.'
      else
        redirect_to admin_conference_boomset_ticket_configs_path(conference_id: @conference.short_title),
                    error: 'Deleting Boomset ticket failed.' \
                    "#{@boomset_ticket_config.errors.full_messages.join('. ')}."
      end
    end

    private

    def boomset_ticket_config_params
      params.require(:boomset_ticket_config).permit(:boomset_registration_type, :ticket_id, :integration_id, :conference_id)
    end
  end
end
