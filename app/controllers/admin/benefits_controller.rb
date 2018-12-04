module Admin
  class BenefitsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource :benefit, through: :conference

    def index
    end

    def new
      @benefit = @conference.benefits.new
    end

    def create
      @benefit = @conference.benefits.new(benefit_params)
      if @benefit.save
        redirect_to admin_conference_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully created.'
      else
        flash[:error] = "Creating Benefit failed: #{@benefit.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def update
      if @benefit.update_attributes(benefit_params)
        redirect_to admin_conference_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully updated.'
      else
        flash[:error] = "Update Benefit failed: #{@benefit.errors.full_messages.join('. ')}."
        render :edit
      end
    end

    def destroy
      if @benefit.destroy
        redirect_to admin_conference_benefits_path(conference_id: @conference.short_title),
                    notice: 'Benefit successfully deleted.'
      else
        redirect_to admin_conference_benefits_path(conference_id: @conference.short_title),
                    error: 'Deleting benefit failed.' \
                    "#{@benefit.errors.full_messages.join('. ')}."
      end
    end

    private

    def benefit_params
      params.require(:benefit).permit(:name, :description, :category, :value_type, :due_date, :conference_id)
    end
  end
end
