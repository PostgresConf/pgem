class TicketPurchasesController < ApplicationController
  load_resource :conference, find_by: :short_title
  before_action :persist_purchase_params, only: :create
  before_filter :authenticate_user!
  authorize_resource :conference_registrations, class: Registration

  def create
    tkts = params[:tickets] || []
    prices = params[:purchase_prices] || []
    code_id = params[:code_id] || ''
    chosen_events = params[:chosen_events] || []

    unless verify_recaptcha
      return redirect_to conference_tickets_path(@conference.short_title)
    end

    if tkts.map(&:values).flatten.map(&:to_i).sum.zero?
      return redirect_to conference_tickets_path(@conference.short_title),
      error: 'Please get at least one ticket to continue.'
    end

    max_qty = 0
    tkts[0].each do |tkt, qty|
      if qty.to_i > max_qty.to_i
        max_qty = qty
      end
    end

    current_user.ticket_purchases.by_conference(@conference).unpaid.destroy_all
    message = TicketPurchase.purchase(@conference, current_user, tkts[0],
                                      code_id, chosen_events, prices[0])
    # this means that TicketPurchase.purchase returned no errors
    if message.blank?
      if current_user.ticket_purchases.by_conference(@conference).unpaid.any?
        redirect_to new_conference_payment_path,
                    notice: 'Please pay here to get tickets.'
      elsif current_user.ticket_purchases.by_conference(@conference).paid.any?
        # Trigger ahoy event
        ahoy.track 'Ticket purchase', title: 'New free purchase'
        # unpaid ticket purchases were destroyed above; if we have paid purchases at this moment
        # this means that .purchase method parked purchase as paid automatically
        # this happens on zero payment amount only hence "free ticket message"
        last_purchase = current_user.ticket_purchases.by_conference(@conference).paid.last

        if last_purchase.code.present?
          notice = "You have free tickets for the conference obtained via #{last_purchase.code.name}"
        else
          notice = 'You have free tickets for the conference.'
        end

        redirect_to complete_conference_tickets_path,
                    notice: notice
      else
        redirect_to conference_tickets_path(@conference.short_title),
                    error: 'Please get at least one ticket to continue.'
      end
    else
      redirect_to conference_conference_registration_path(@conference.short_title),
                  error: "Oops, something went wrong with your purchase! #{message}"
    end
  end

  def recreate
    render layout: false
  end

  def quickbuy
    event = Event.find(params[:event_id])

    if event
      if event.ticket
        tid = event.ticket.id.to_s
        session[:purchase_params_tickets] = [{tid => "1"}]
        session[:purchase_params_purchase_prices] = [{tid =>"0.00"}]
        session[:purchase_params_chosen_events] = {tid => {event.id.to_s =>"1"}}
        redirect_to conference_ticket_purchases_recreate_path(@conference.short_title) and return
      end
    end

    redirect_to conference_tickets_path(@conference.short_title),
                  error: 'Please get at least one ticket to continue.'
  end

  private

  def ticket_purchase_params
    params.require(:ticket_purchase).permit(:ticket_id, :user_id, :conference_id, :quantity, :code_id, :event_id)
  end

  def persist_purchase_params
    # user signed in, restore form params while user was not signed in (if any)
    if user_signed_in?
      params[:tickets] ||= session.delete(:purchase_params_tickets)
      params[:purchase_prices] ||= session.delete(:purchase_params_purchase_prices)
      params[:chosen_events] ||= session.delete(:purchase_params_chosen_events)
      params[:code_id] ||= session.delete(:purchase_params_code_id)

    # for anonymous user store ticket choices and prices
    else
      session[:purchase_params_tickets] = params[:tickets]
      session[:purchase_params_purchase_prices] = params[:purchase_prices]
      session[:purchase_params_chosen_events] = params[:chosen_events]
      session[:purchase_params_code_id] = params[:code_id] if params[:code_id]
      session[:return_to] = conference_ticket_purchases_recreate_path(@conference.short_title)
    end
  end
end
