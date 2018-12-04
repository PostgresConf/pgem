module Portal
  class BenefitResponsesController < Portal::BaseController
    load_and_authorize_resource :sponsor, find_by: :short_name
    load_and_authorize_resource :conference, find_by: :short_title

    before_action :check_user_privs

    def new
      @sponsorship = Sponsorship.find_sponsorship(@conference, @sponsor)

      @benefit_response = BenefitResponse.new(conference_id: @conference.id, sponsorship_id: @sponsorship.id, benefit_id: params[:bid])

      @benefit = Benefit.find(params[:bid])
    end

    def create
      @sponsorship = Sponsorship.find_sponsorship(@conference, @sponsor)

      @benefit_response = @sponsorship.benefit_responses.new(benefit_response_params)
      @benefit_response.conference_id = @conference.id
      @benefit_response.sponsorship_id = @sponsorship.id
      #@benefit_response.benefit_id = benefit_id

      if @benefit_response.save
        redirect_to portal_sponsor_conference_path(@sponsor.short_name, @conference.short_title),
                    notice: 'Response successfully saved.'
      else
        flash[:error] = "Creating Response failed: #{@benefit_response.errors.full_messages.join('. ')}."
        render :new
      end
    end

    def edit
      @benefit_response = BenefitResponse.find(params[:id])
      @benefit = Benefit.find(@benefit_response.benefit_id)
    end

    def update
      @benefit_response = BenefitResponse.find(params[:id])

      if @benefit_response.update(benefit_response_params)
        redirect_to portal_sponsor_conference_path(@sponsor.short_name, @conference.short_title),
                    notice: 'Response successfully saved.'
      else
        flash[:error] = "Creating Response failed: #{@benefit_response.errors.full_messages.join('. ')}."
        render :edit
      end

    end

    def show
    end

    private

    def benefit_response_params
      params.require(:benefit_response).permit(:conference, :sponsorship, :benefit_id, :text_response, :file_response, :bool_response)
    end

  end
end
