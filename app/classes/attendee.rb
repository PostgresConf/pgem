class Attendee 
  require 'json'

  attr_accessor :type
  attr_accessor :data

  class Data < Attendee 
    attr_accessor :id
    attr_accessor :type
    attr_accessor :event
    attr_accessor :registrant

    class Type < Data
      attr_accessor :id
      attr_accessor :name
    end

    class Event < Data
      attr_accessor :url
      attr_accessor :name
    end

    class Registrant < Data
      attr_accessor :first_name
      attr_accessor :last_name
      attr_accessor :job_title
      attr_accessor :company
      attr_accessor :phone
      attr_accessor :email
      attr_accessor :address

      class Address < Registrant
        attr_accessor :street_address
        attr_accessor :extended_address
        attr_accessor :locality
        attr_accessor :region
        attr_accessor :postal_code
        attr_accessor :country
      end

      class Ticket < Registrant
        attr_accessor :ticket_type
	attr_accessor :paid
	attr_accessor :cost
        attr_accessor :token
      end
    end
  end
end
