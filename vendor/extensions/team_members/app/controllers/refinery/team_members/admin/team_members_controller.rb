module Refinery
  module TeamMembers
    module Admin
      class TeamMembersController < ::Refinery::AdminController

        crudify :'refinery/team_members/team_member',
                :title_attribute => 'firstname'

        private

        # Only allow a trusted parameter "white list" through.
        def team_member_params
          params.require(:team_member).permit(:firstname, :middlename, :lastname, :role, :photo_id, :description, :twitter, :linkedin)
        end
      end
    end
  end
end
