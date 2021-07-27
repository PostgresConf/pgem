module Refinery
  module CommunityEvents
    class CommunityEvent < Refinery::Core::BaseModel
      self.table_name = 'refinery_community_events'


      validates :title, :presence => true, :uniqueness => true

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      acts_as_indexed :fields => [:title]
      class << self
        def newest_first
          order("published_at DESC")
        end

        def recent(count)
          newest_first.limit(count)
        end
      end

    end
  end
end
