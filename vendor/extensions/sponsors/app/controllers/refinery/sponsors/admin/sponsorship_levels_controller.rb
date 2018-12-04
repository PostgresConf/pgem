module Refinery
  module Sponsors
    module Admin
      class SponsorshipLevelsController < ::Refinery::AdminController

        crudify :'refinery/sponsors/sponsorship_level',
                :title_attribute => 'name'

        private

        # Only allow a trusted parameter "white list" through.
        def sponsorship_level_params
          params.require(:sponsorship_level).permit(:name)
        end
      end
    end
  end
end
