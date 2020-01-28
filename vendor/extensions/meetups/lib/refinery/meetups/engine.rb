module Refinery
  module Meetups
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Meetups

      engine_name :refinery_meetups

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "meetups"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.meetups_admin_meetups_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Meetups)
      end
    end
  end
end
