class Mailbot < ActionMailer::Base
  def registration_mail(conference, user)
    mail(to: user.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_conf_template(conference,
                                                                 user,
                                                                 conference.email_settings.registration_subject),
         body: conference.email_settings.expand_conf_template(conference,
                                                              user,
                                                              conference.email_settings.registration_body))
  end

  def purchase_confirmation_mail(payment)
    @payment = payment
    @lines = TicketPurchase.where(payment_id: @payment.id)
    @user = payment.user
    @conference = payment.conference

    filename = @conference.short_title + '_payment-' + @payment.id.to_s + '.pdf'
    pdf = ReceiptPdf.new(@conference, @user, @payment, @lines)
    attachments[filename] = InvoicePrinter.render(document: pdf, logo: File.expand_path('app/assets/images/PPD_logo.png'))

    mail(to: @user.email,
         from: @conference.contact.email,
         template_name: 'purchase_confirmation_template.text.erb',
         subject: "#{@conference.title} | Purchase Confirmation")
  end

  def ticket_confirmation_mail(ticket_purchase)
    @ticket_purchase = ticket_purchase
    @conference = ticket_purchase.conference
    @user = ticket_purchase.user

    PhysicalTicket.last(ticket_purchase.quantity).each do |physical_ticket|
      pdf = TicketPdf.new(@conference, @user, physical_ticket, @conference.ticket_layout.to_sym, "ticket_for_#{@conference.short_title}_#{physical_ticket.id}")
      attachments["ticket_for_#{@conference.short_title}_#{physical_ticket.id}.pdf"] = pdf.render
    end

    mail(to: @user.email,
         from: @conference.contact.email,
         template_name: 'ticket_confirmation_template',
         subject: "#{@conference.title} | Ticket Confirmation and PDF!")
  end

  def assign_ticket_mail(physical_ticket, to_user)
    @physical_ticket = physical_ticket
    @from_user = @physical_ticket.ticket_purchase.user
    @to_user = to_user
    @conference = @physical_ticket.conference
    @ticket = @physical_ticket.ticket
    @event = @physical_ticket.event

    pdf = TicketPdf.new(@conference, @to_user, @physical_ticket, @conference.ticket_layout.to_sym, "ticket_for_#{@conference.short_title}_#{@physical_ticket.id}")
    attachments["ticket_for_#{@conference.short_title}_#{@physical_ticket.id}.pdf"] = pdf.render

    mail(to: @to_user.email,
         cc: @from_user.email,
         from: @conference.contact.email,
         template_name: 'ticket_assign_template.text.erb',
         subject: "#{@conference.title} | Ticket Assignment")
  end

  def pending_assign_ticket_mail(physical_ticket, to_user)
    @physical_ticket = physical_ticket
    @from_user = @physical_ticket.ticket_purchase.user
    @conference = @physical_ticket.conference
    @ticket = @physical_ticket.ticket
    @event = @physical_ticket.event
    @reg_link = Rails.application.routes.url_helpers.claim_conference_physical_ticket_url(
                            @conference.short_title, host: (ENV['OSEM_HOSTNAME'] || 'localhost:3000'), id: @physical_ticket.token ) 

    mail(to: to_user,
         cc: @from_user.email,
         from: @conference.contact.email,
         template_name: 'pending_ticket_assign_template.text.erb',
         subject: "#{@conference.title} | Ticket Assignment")
  end

  def acceptance_mail(event, recipient)
    conference = event.program.conference
    mail(to: recipient.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_event_template(event, recipient, conference.email_settings.accepted_subject),
         body: conference.email_settings.expand_event_template(event, recipient, conference.email_settings.accepted_body))
  end

  def rejection_mail(event, recipient)
    conference = event.program.conference

    mail(to: recipient.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_event_template(event, recipient, conference.email_settings.rejected_subject),
         body: conference.email_settings.expand_event_template(event, recipient, conference.email_settings.rejected_body))
  end

  def confirm_reminder_mail(event, recipient)
    conference = event.program.conference

    mail(to: recipient.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_event_template(event, recipient, conference.email_settings.confirmed_without_registration_subject),
         body: conference.email_settings.expand_event_template(event, recipient,
                                                               conference.email_settings.confirmed_without_registration_body))
  end

  def conference_date_update_mail(conference, user)
    mail(to: user.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_conf_template(conference, user, conference.email_settings.conference_dates_updated_subject),
         body: conference.email_settings.expand_conf_template(conference,
                                                              user,
                                                              conference.email_settings.conference_dates_updated_body))
  end

  def conference_registration_date_update_mail(conference, user)
    mail(to: user.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_conf_template(conference,
                                                                 user,
                                                                 conference.email_settings.conference_registration_dates_updated_subject),
         body: conference.email_settings.expand_conf_template(conference,
                                                              user,
                                                              conference.email_settings.conference_registration_dates_updated_body))
  end

  def conference_venue_update_mail(conference, user)
    mail(to: user.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_conf_template(conference, user, conference.email_settings.venue_updated_subject),
         body: conference.email_settings.expand_conf_template(conference,
                                                              user,
                                                              conference.email_settings.venue_updated_body))
  end

  def conference_schedule_update_mail(conference, user)
    mail(to: user.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_conf_template(conference, user, conference.email_settings.program_schedule_public_subject),
         body: conference.email_settings.expand_conf_template(conference,
                                                              user,
                                                              conference.email_settings.program_schedule_public_body))
  end

  def conference_cfp_update_mail(conference, user)
    mail(to: user.email,
         from: conference.contact.email,
         subject: conference.email_settings.expand_conf_template(conference, user, conference.email_settings.cfp_dates_updated_subject),
         body: conference.email_settings.expand_conf_template(conference,
                                                              user,
                                                              conference.email_settings.cfp_dates_updated_body))
  end

  def event_comment_mail(comment, user)
    @comment = comment
    @event = @comment.commentable
    @conference = @event.program.conference
    @user = user

    mail(to: @user.email,
         from: @conference.contact.email,
         template_name: 'comment_template',
         subject: "New comment has been posted for #{@event.title}")
  end
end
