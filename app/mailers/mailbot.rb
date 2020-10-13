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
    lines = payment.ticket_purchases
    user = payment.user
    conference = payment.conference

    filename = "#{conference.short_title}_payment-#{payment.id}.pdf"
    pdf = ReceiptPdf.new(conference, user, payment, lines)
    # TODO: make logo path configurable
    attachments[filename] = InvoicePrinter.render(document: pdf, logo: File.expand_path('app/assets/images/PPD_logo.png'))

    body = conference.email_settings.expand_payment_template(
      conference,
      user,
      conference.email_settings.purchase_confirmation_body,
      payment)

    subject = conference.email_settings.expand_payment_template(
      conference,
      user,
      conference.email_settings.purchase_confirmation_subject,
      payment)

    mail(to: user.email,
      from: conference.contact.email,
      subject: subject,
      body: body)
  end

  def ticket_confirmation_mail(ticket_purchase)
    conference = ticket_purchase.conference
    user = ticket_purchase.user

    if conference.email_settings.send_ticket_pdf
      ticket_purchase.physical_tickets.each do |physical_ticket|
        pdf = TicketPdf.new(conference, user, physical_ticket, conference.ticket_layout.to_sym, "ticket_for_#{conference.short_title}_#{physical_ticket.id}")
        attachments["ticket_for_#{conference.short_title}_#{physical_ticket.id}.pdf"] = pdf.render
      end
    end

    body = conference.email_settings.expand_ticket_purchase_template(
      conference,
      user,
      conference.email_settings.ticket_confirmation_body,
      ticket_purchase)

    subject = conference.email_settings.expand_ticket_purchase_template(
      conference,
      user,
      conference.email_settings.ticket_confirmation_subject,
      ticket_purchase)

    mail(to: user.email,
      from: conference.contact.email,
      subject: subject,
      body: body)
  end

  def assign_ticket_mail(physical_ticket, to_user)
    from_user = physical_ticket.ticket_purchase.user
    conference = physical_ticket.conference
    ticket = physical_ticket.ticket
    event = physical_ticket.event

    pdf = TicketPdf.new(conference, to_user, physical_ticket, conference.ticket_layout.to_sym, "ticket_for_#{conference.short_title}_#{physical_ticket.id}")
    attachments["ticket_for_#{conference.short_title}_#{physical_ticket.id}.pdf"] = pdf.render

    body = conference.email_settings.expand_assign_ticket_template(
      conference,
      to_user,
      conference.email_settings.assign_ticket_body,
      physical_ticket)

    subject = conference.email_settings.expand_assign_ticket_template(
      conference,
      to_user,
      conference.email_settings.assign_ticket_subject,
      physical_ticket)

    mail(to: to_user.email,
      cc: from_user.email,
      from: conference.contact.email,
      subject: subject,
      body: body)
  end

  def pending_assign_ticket_mail(physical_ticket, to_user)
    from_user = physical_ticket.ticket_purchase.user
    conference = physical_ticket.conference
    ticket = physical_ticket.ticket
    event = physical_ticket.event

    body = conference.email_settings.expand_assign_ticket_template(
      conference,
      from_user,
      conference.email_settings.pending_assign_ticket_body,
      physical_ticket)

    subject = conference.email_settings.expand_assign_ticket_template(
      conference,
      from_user,
      conference.email_settings.pending_assign_ticket_subject,
      physical_ticket)

    mail(to: to_user,
      cc: from_user.email,
      from: conference.contact.email,
      subject: subject,
      body: body)
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
    @event = comment.commentable
    @conference = @event.program.conference
    @user=user
    @comment = comment

    mail(to: user.email,
         from: @conference.contact.email,
         template_name: 'comment_template',
         subject: "New comment has been posted for #{@event.title}")
  end

  def invitation_mail(invitation)
    @event = invitation.event
    @conference = @event.program.conference
    @user = User.find_by_email(invitation.email)
    @username = @user.present? ? @user.name : invitation.email
    @invitation = invitation
    mail(to: invitation.email,
         from: @conference.contact.email,
         template_name: 'speaker_invitation_template',
         subject: "You have been invited as a speaker to #{@event.title}")
  end
end
