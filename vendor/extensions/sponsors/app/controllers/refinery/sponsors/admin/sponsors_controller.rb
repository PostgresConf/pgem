module Refinery
  module Sponsors
    module Admin
      class SponsorsController < ::Refinery::AdminController
        before_filter :find_all_sponsorship_levels
        crudify :'refinery/sponsors/sponsor',
                :title_attribute => 'name'

        protected

        def find_all_sponsorship_levels
          @sponsorship_levels = ::Refinery::Sponsors::SponsorshipLevel.order('name ASC')
        end

        private

        # Only allow a trusted parameter "white list" through.
        def sponsor_params
          params.require(:sponsor).permit(:name, :url, :logo_id, :description, :sponsorship_level_id)
        end
      end
    end
  end
end
