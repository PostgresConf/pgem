class PhysicalTicketController < ApplicationController
  before_action :authenticate_user!, except: [:claim, :assign]
  load_resource :conference, find_by: :short_title
  load_resource :ticket_purchase
  load_and_authorize_resource :physical_ticket, find_by: :token
  authorize_resource :conference_registrations, class: Registration

  def update
    assigned_attendee = physical_ticket_params[:email]

    attendee = User.where(email: assigned_attendee).first

    if attendee.present?
      PhysicalTicket.assign(@physical_ticket.ticket_purchase, attendee, @physical_ticket.token, @physical_ticket.event_id)
      Mailbot.assign_ticket_mail(@physical_ticket, attendee).deliver_now
      redirect_to conference_physical_ticket_index_path, notice: 'The ticket has been assigned to ' + attendee.name + '.'
    else
      if assigned_attendee =~ Devise.email_regexp
        @physical_ticket.pending_assignment = assigned_attendee
        if @physical_ticket.save
          Mailbot.pending_assign_ticket_mail(@physical_ticket, assigned_attendee).deliver_now
        end
        redirect_to conference_physical_ticket_index_path, error: 'The email (' + assigned_attendee + ') is not a registered PGConf user. An email has been sent to the attendee to complete the transfer.'
      else
        redirect_to conference_physical_ticket_index_path, error: 'The email (' + assigned_attendee + ') you entered is not a valid email address. Please confirm you have entered it correctly.'
      end
    end
  end

  def index
    @physical_tickets = PhysicalTicket.user_tickets(@conference, current_user)
    @unpaid_ticket_purchases = current_user.ticket_purchases.by_conference(@conference).unpaid
  end

  def show
    @file_name = "ticket_for_#{@conference.short_title}"
    @user = @physical_ticket.user
    @ticket_layout = @conference.ticket_layout.to_sym
    @qrcode_image = RQRCode::QRCode.new(@physical_ticket.token).as_png(size: 180, border_modules: 0)
    respond_to do |format|
      format.html
      format.pdf do
        pdf = TicketPdf.new(@conference, @user, @physical_ticket, @ticket_layout, @file_name)
        send_data pdf.render,
                  filename: @file_name,
                  type: 'application/pdf',
                  disposition: 'attachment'
      end
    end
  end

  def claim
    company = @physical_ticket.user.affiliation
    email = @physical_ticket.pending_assignment

    @physical_ticket.user = User.new
    @physical_ticket.user.affiliation = company
    @physical_ticket.user.email = email

  end

  def assign
    unless current_user
      @user = User.new(physical_ticket_params)
      @user.username = @user.email
      @user.confirmed_at = DateTime.now
      @user.skip_confirmation!

      if @user.save
        sign_in(@user)
      else
        flash.now[:error] = "Could not save user: #{@user.errors.full_messages.join(', ')}"
        return
      end
    end

    PhysicalTicket.claim_tickets(current_user)
    redirect_to conference_physical_ticket_index_path, notice: 'Ticket was successfully assigned.'
  end

  private

  def physical_ticket_params
    params.require(:physical_ticket).permit(:email, :first_name, :last_name,
                   :title, :password, :password_confirmation, :affiliation, :mobile)
  end


end
