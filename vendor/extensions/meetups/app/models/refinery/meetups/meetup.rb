module Refinery
  module Meetups
    class Meetup < Refinery::Core::BaseModel
      self.table_name = 'refinery_meetups'

      validates :url, :presence => true, :uniqueness => true
      class << self
        def earliest
          where('start > ?', DateTime.now)
        end

        def upcoming(count)
          earliest.order('start ASC').limit(count)
        end
      end

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
