module Refinery
  module Sponsors
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Sponsors

      engine_name :refinery_sponsors

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "sponsorship_levels"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.sponsors_admin_sponsorship_levels_path }
          plugin.pathname = root
          plugin.menu_match = %r{refinery/sponsors/sponsorship_levels(/.*)?$}
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::SponsorshipLevels)
      end
    end
  end
end
