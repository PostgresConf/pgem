module Admin
  class CodesController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, except: [:new, :create]

    def index; end

    def show
    end

    def new
       @code = Code.new(conference_id: @conference.id)
       authorize! :create, @code
    end

    def create
      @code = @conference.codes.new(code_params)
      @code.conference_id = @conference.id
      authorize! :create, @code

      if @conference.save
        redirect_to admin_conference_codes_path, notice: 'Promo Code was successfully created.'
      else
        flash.now[:error] = "Oops, couldn't save Promo Code. #{@code.errors.full_messages.join('. ')}"
        render :new
      end
    end

    # PUT codes/1
    def update
      if @code.update_attributes(code_params)
        redirect_to admin_conference_codes_path(conference_id: @conference.short_title), notice: "Promo Code '#{@code.name}' for #{@conference.short_title} successfully updated."
      else
        flash.now[:error] = "Update of promo code for #{@conference.short_title} failed. #{@code.errors.full_messages.join('. ')}"
        render :edit
      end
    end

    def destroy
      @code.destroy
      redirect_to admin_conference_codes_path(conference_id: @conference.short_title), notice: 'Promocode was successfully destroyed.'
    end

    # Update codes used for the conference
    def update_conference
      authorize! :update, Code.new(conference_id: @conference.id)
      if @conference.update_attributes(conference_params)
        redirect_to admin_conference_codes_path(conference_id: @conference.short_title), notice: "Promo Codes for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_codes_path(conference_id: @conference.short_title), notice: "Update of promo codes for #{@conference.short_title} failed."
      end
    end


    private

    def code_params
      params.require(:code).permit(:name, :discount, :max_uses, :code_type_id, :conference_id, :sponsor_id, :ticket_ids => [])
    end

    def conference_params
      params.require(:conference).permit(code_ids: [])
    end
  end
end
