class TicketsController < ApplicationController
  before_action :store_user_location!
  before_filter :authenticate_user!
  load_resource :conference, find_by: :short_title
  load_resource :ticket, through: :conference
  authorize_resource :conference_registrations, class: Registration
  before_filter :check_load_resource, only: :index

  def index
  @tix = params['ticket']

  if ticket_params.present?

      applied_code = ticket_params[:promo_code][:pcode]
      code = @conference.get_valid_code(applied_code)
      @discount_pct = 0.0

      if code.present?
        if TicketPurchase.get_code_usage(@conference, code) >= code.max_uses && code.max_uses != 0
          flash.now[:warning] = "The Promotional Code (#{applied_code}) has aleady been used"
        else
          flash.now[:notice] = "The Promotional Code (#{applied_code}) has been applied."
          @applied_code = code
        end
      else
        flash.now[:notice] = "The Promotional Code (#{applied_code}) is not valid."
      end
    end

    Ticket.applied_code = code
  end

  def check_load_resource
    if @tickets.empty?
      redirect_to root_path, notice: "There are no tickets available for #{@conference.title}!"
    end
  end

  def authenticate_user!
    redirect_to( new_user_registration_path) unless user_signed_in?
  end

  private

  def store_user_location!
    session[:previous_url] = request.fullpath
  end

  def ticket_params
    params.permit(promo_code: [:pcode])
  end
end
