module Admin
  class IntegrationsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :integration, through: :conference

    def index
    end

    def new
      @integration = @conference.integrations.new
    end

    def create
      @integration = @conference.integrations.new(integration_params)
      if @integration.save
        redirect_to admin_conference_integrations_path(conference_id: @conference.short_title),
                    notice: 'Integration successfully created.'
      else
        flash[:error] = "Creating Integration failed: #{@integration.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def edit; end

    def update
      if @integration.update_attributes(integration_params)
        redirect_to admin_conference_integrations_path(conference_id: @conference.short_title),
                    notice: 'Integration successfully updated.'
      else
        flash[:error] = "Update Integration failed: #{@integration.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @integration.destroy
        redirect_to admin_conference_integrations_path(conference_id: @conference.short_title),
                    notice: 'Integration successfully deleted.'
      else
        redirect_to admin_conference_integrations_path(conference_id: @conference.short_title),
                    error: 'Deleting integration failed.' \
                    "#{@integration.errors.full_messages.join('. ')}."
      end
    end

    private

    def integration_params
      params.require(:integration).permit(:integration_type, :key, :url, :integration_config_key, :conference_id)
    end
  end
end
