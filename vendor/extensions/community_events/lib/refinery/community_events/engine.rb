module Refinery
  module CommunityEvents
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::CommunityEvents

      engine_name :refinery_community_events

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "community_events"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.community_events_admin_community_events_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::CommunityEvents)
      end
    end
  end
end
