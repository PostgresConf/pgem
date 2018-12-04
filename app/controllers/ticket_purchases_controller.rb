class TicketPurchasesController < ApplicationController
  before_filter :authenticate_user!
  load_resource :conference, find_by: :short_title
  authorize_resource :conference_registrations, class: Registration

  def create
    if params[:tickets].nil?
        tkts = Array.new
    else
        tkts = params[:tickets]
    end
    
    if params[:purchase_prices].nil?
      prices = Array.new
    else
      prices = params[:purchase_prices]
    end

    max_qty = 0
    tkts[0].each do |tkt, qty|
      if qty.to_i > max_qty.to_i
        max_qty = qty
      end
    end
    
    current_user.ticket_purchases.by_conference(@conference).unpaid.destroy_all

    if params[:code_id].nil?
        code_id = ''
    else
        code_id = params[:code_id]
    end

    if params[:chosen_events].nil?
        chosen_events = nil 
    else
        chosen_events = params[:chosen_events]
    end

    message = TicketPurchase.purchase(@conference, current_user, tkts[0],
                                      code_id, chosen_events, prices[0])
    if message.blank?
      if current_user.ticket_purchases.by_conference(@conference).unpaid.any?
        redirect_to new_conference_payment_path,
                    notice: 'Please pay here to get tickets.'
      elsif current_user.ticket_purchases.by_conference(@conference).paid.any?
        redirect_to conference_physical_ticket_index_path,
                    notice: 'You have free tickets for the conference.'
      else
        redirect_to conference_tickets_path(@conference.short_title),
                    error: 'Please get at least one ticket to continue.'
      end
    else
      redirect_to conference_conference_registration_path(@conference.short_title),
                  error: "Oops, something went wrong with your purchase! #{message}"
    end
  end

  private

  def ticket_purchase_params
    params.require(:ticket_purchase).permit(:ticket_id, :user_id, :conference_id, :quantity, :code_id, :event_id)
  end
end
