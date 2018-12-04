module Refinery
  module Sponsors
    class SponsorshipLevel < Refinery::Core::BaseModel


      validates :name, :presence => true, :uniqueness => true
      has_many :sponsors, class_name: '::Refinery::Sponsors::Sponsor'

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

      def logo_size
        logo_sizes = ['70000@','35000@','12000@', '10000@']
      	logo_sizes[self.position] || '10000@'
      end
    end
  end
end
