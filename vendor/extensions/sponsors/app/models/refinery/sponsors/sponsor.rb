module Refinery
  module Sponsors
    class Sponsor < Refinery::Core::BaseModel
      self.table_name = 'refinery_sponsors'


      validates :name, :presence => true, :uniqueness => true
      validates :logo, :presence => true

      belongs_to :logo, :class_name => '::Refinery::Image'
      belongs_to :sponsorship_level, class_name: '::Refinery::Sponsors::SponsorshipLevel'

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]

    end
  end
end
