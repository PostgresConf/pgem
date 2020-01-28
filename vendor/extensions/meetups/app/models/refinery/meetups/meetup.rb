module Refinery
  module Meetups
    class Meetup < Refinery::Core::BaseModel
      self.table_name = 'refinery_meetups'


      validates :url, :presence => true, :uniqueness => true
      class << self
        def newest_first
          order("start DESC")
        end

        def upcoming(count)
          newest_first.limit(count)
        end
      end

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
