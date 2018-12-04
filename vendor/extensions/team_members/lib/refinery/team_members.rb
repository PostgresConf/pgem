require 'refinerycms-core'

module Refinery
  autoload :TeamMembersGenerator, 'generators/refinery/team_members_generator'

  module TeamMembers
    require 'refinery/team_members/engine'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
