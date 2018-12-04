module Refinery
  module TeamMembers
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::TeamMembers

      engine_name :refinery_team_members

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "team_members"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.team_members_admin_team_members_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::TeamMembers)
      end
    end
  end
end
