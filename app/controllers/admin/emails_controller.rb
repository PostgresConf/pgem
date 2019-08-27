module Admin
  class EmailsController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource class: EmailSettings

    def update
      if @conference.email_settings.update(email_params)
        redirect_to admin_conference_emails_path(
                    @conference.short_title),
                    notice: 'Email settings have been successfully updated.'
      else
        redirect_to admin_conference_emails_path(
                    @conference.short_title),
                    error: "Updating email settings failed. #{@conference.email_settings.errors.to_a.join('. ')}."
      end
    end

    def index
      authorize! :index, @conference.email_settings
      @settings = @conference.email_settings
    end

    private

    def email_params
      params.require(:email_settings).permit(:send_on_registration, :send_on_accepted, :send_on_rejected, :send_on_confirmed_without_registration,
                                             :registration_subject, :accepted_subject, :rejected_subject, :confirmed_without_registration_subject,
                                             :registration_body, :accepted_body, :rejected_body, :confirmed_without_registration_body,
                                             :send_on_conference_dates_updated, :conference_dates_updated_subject, :conference_dates_updated_body,
                                             :send_on_conference_registration_dates_updated, :conference_registration_dates_updated_subject, :conference_registration_dates_updated_body,
                                             :send_on_venue_updated, :venue_updated_subject, :venue_updated_body,
                                             :send_on_cfp_dates_updated, :cfp_dates_updated_subject, :cfp_dates_updated_body,
                                             :send_on_program_schedule_public, :program_schedule_public_subject, :program_schedule_public_body,
                                             :purchase_confirmation_subject, :purchase_confirmation_body, :ticket_confirmation_subject, :ticket_confirmation_body,
                                             :assign_ticket_subject, :assign_ticket_body, :pending_assign_ticket_subject, :pending_assign_ticket_body, :send_ticket_pdf)
    end
  end
end
