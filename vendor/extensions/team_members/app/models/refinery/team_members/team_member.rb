module Refinery
  module TeamMembers
    class TeamMember < Refinery::Core::BaseModel
      self.table_name = 'refinery_team_members'


      validates :firstname, :presence => true

      belongs_to :photo, :class_name => '::Refinery::Image'

      validate :description_limit

      # To enable admin searching, add acts_as_indexed on searchable fields, for example:
      #
      #   acts_as_indexed :fields => [:title]
      def fullname
        [firstname,middlename,lastname].join(' ')
      end

      def description_limit
        if self.description.present?
          errors.add(:description, 'is limited to 50 words.') if self.description.split.length > 50
        end
      end
    end
  end
end
