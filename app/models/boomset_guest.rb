class BoomsetGuest < ActiveRecord::Base
  belongs_to :conference
  belongs_to :registration
  belongs_to :integration

  def self.get_guest(registration)
      g = BoomsetAttendee.new

      unless registration.first_name.blank?
          g.first_name = registration.first_name
      end

      unless registration.last_name.blank?
          g.last_name = registration.last_name
      end

      unless registration.email.blank?
          g.email = registration.email
      end

      unless registration.mobile.blank?
          g.cell_phone = registration.mobile
      end

      unless registration.affiliation.blank?
          g.company = registration.affiliation
      end

      unless registration.title.blank?
          g.job_title = registration.title
      end

      pt = PhysicalTicket.where(registration_id: registration.id)
	                 .joins(:ticket_purchase)
	                 .joins(:ticket)
	                 .order("tickets.position").first

      unless pt.token.blank?
          g.barcode = pt.token
	  g.nfc_tag = pt.token
      end

      btc = BoomsetTicketConfig.where(conference_id: registration.conference_id, ticket_id: pt.ticket.id).first

      unless btc.boomset_registration_type.blank?
	  g.registration_type = btc.boomset_registration_type
      end

      g
  end
end
