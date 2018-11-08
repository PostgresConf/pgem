class ConferenceRegistrationsController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  load_resource :conference, find_by: :short_title
  authorize_resource :conference_registrations, class: Registration, except: [:new, :create]
  before_action :set_registration, only: [:edit, :update, :destroy, :show]

  def new
    @registration = Registration.new(conference_id: @conference.id)
    authorize! :new, @registration, message: "Sorry, you can not register for #{@conference.title}. Registration limit exceeded or the registration is not open."

    # Redirect to registration edit when user is already registered
    if @conference.user_registered?(current_user)
      redirect_to edit_conference_conference_registration_path(@conference.short_title)
      return
    # ichain does not allow us to create users during registration
    elsif (ENV['OSEM_ICHAIN_ENABLED'] == 'true') && !current_user
      redirect_to root_path, alert: 'You need to sign in or sign up before continuing.'
      return
    end

    # avoid openid sign_in to redirect to register/new when the sign_in user had already a registration
    if current_user && @conference.user_registered?(current_user)
      redirect_to edit_conference_conference_registration_path(@conference.short_title)
    end

    # @user variable needs to be set so that _sign_up_form_embedded works properly
    @user = @registration.build_user
  end

  def show
    @total_price = Ticket.total_price(@conference, current_user, paid: true)
    @tickets = current_user.ticket_purchases.by_conference(@conference).paid
    @ticket_payments = @tickets.group_by(&:ticket_id)
    @total_quantity = @tickets.group(:ticket_id).sum(:quantity)
    @payments = Payment.where(conference_id: @conference.id, user_id: current_user.id, status: 1)
    @payment_quantity = @payments.count
  end

  def edit; end

  def create
    @registration = @conference.registrations.new(registration_params)

    if current_user.nil?
      # @user variable needs to be set so that _sign_up_form_embedded works properly
      @user = @registration.build_user(user_params)
    else
      @user = current_user
    end

    if @conference.use_pg_flow
        @user.username = @user.email
    end

    @registration.user = @user
    authorize! :create, @registration

    if @registration.save
      # Trigger ahoy event
      ahoy.track 'Registered', title: 'New registration'

      # Sign in the new user
      unless current_user
        sign_in(@registration.user)
      end

      if @conference.tickets.any? && !current_user.supports?(@conference)
        redirect_to conference_tickets_path(@conference.short_title),
                    notice: 'You are now registered and will be receiving E-Mail notifications.'
      else
        redirect_to conference_conference_registration_path(@conference.short_title),
                    notice: 'You are now registered and will be receiving E-Mail notifications.'
      end
    else
      flash.now[:error] = "Could not create your registration for #{@conference.title}: "\
                        "#{@registration.errors.full_messages.join('. ')}."
      render :new
    end
  end

  protected

  def set_registration
    @registration = Registration.find_by(conference: @conference, user: current_user)
    unless @registration
      if current_user.ticket_purchases.by_conference(@conference).any?
        create
      else
        redirect_to conference_tickets_path(@conference.short_title),
                    error: "Can't find a registration for #{@conference.title} for you. Please register."
      end
    end

    current_user.ticket_purchases.by_conference(@conference).paid.each do |tp|
      if tp.event.present?
        if @registration.events.exclude? tp.event
          @registration.events << tp.event
        end
      end

    end

  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :title, :affiliation, :mobile, 
      :username, :email, :name, :password, :password_confirmation)
  end

  def registration_params
    # All parameters can be optional at least initially so no params are required
    params.permit(
          :registration,
          :arrival, :departure,
          :volunteer,
          vchoice_ids: [], qanswer_ids: [],
          qanswers_attributes: [],
          event_ids: [],
          user_attributes: [
            :first_name, :last_name, :title, :affiliation, :mobile,
            :username, :email, :name, :password, :password_confirmation]
    )
  end
end
