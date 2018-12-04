module Refinery
  module Sponsors
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Sponsors

      engine_name :refinery_sponsors

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "sponsors"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sponsors_admin_sponsors_path }
          plugin.pathname = root
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Sponsors)
      end
    end
  end
end
