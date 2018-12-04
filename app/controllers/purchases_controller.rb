class PurchasesController < ApplicationController
  load_resource :conference, find_by: :short_title
  authorize_resource :conference_registrations, class: Registration
  before_action :authenticate_user!

  def index
    @purchases = Payment.purchases(@conference, current_user)
  end

  def show
    @payment = Payment.find(params[:id])
    check_user_privs
    @lines = TicketPurchase.where(payment_id: @payment.id)

    respond_to do |format|
      format.html
      format.pdf do
        filename = @conference.short_title + '_payment-' + @payment.id.to_s + '.pdf'
        pdf = ReceiptPdf.new(@conference, current_user, @payment, @lines)
        send_data InvoicePrinter.render(document: pdf, logo: File.expand_path('app/assets/images/PPD_logo.png')),
                  filename: filename,
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end

  end

  private

  def check_user_privs
    return unless @payment.user_id != current_user.id

    redirect_to conference_path(@conference.short_title),
                  alert: 'You are not permitted to view that page'
  end

end
