module Admin
  class ConferenceTeamMembersController < Admin::BaseController
    load_and_authorize_resource :conference, find_by: :short_title
    load_and_authorize_resource through: :conference, except: [:new, :create]

    def index; end

    def show
    end

    def new
       @team_member = ConferenceTeamMember.new(conference_id: @conference.id)
       authorize! :create, @team_member
    end

    def create
      @team_member = @conference.conference_team_members.new(conference_team_member_params)
      @team_member.conference_id = @conference.id
      authorize! :create, @team_member

      if @conference.save
        redirect_to admin_conference_conference_team_members_path, notice: 'Team member added.'
      else
        flash.now[:error] = "Oops, couldn't add the team member. #{@team_member.errors.full_messages.join('. ')}"
        render :new
      end
    end

    def destroy
      @conference_team_member.destroy
      redirect_to admin_conference_conference_team_members_path(conference_id: @conference.short_title), notice: 'Team Member was successfully removed.'
    end

    # Update team_members used for the conference
    def update_conference
      authorize! :update, ConferenceTeamMember.new(conference_id: @conference.id)
      if @conference.update_attributes(conference_params)
        redirect_to admin_conference_conference_team_members_path(conference_id: @conference.short_title), notice: "Team Member for #{@conference.short_title} successfully updated."
      else
        redirect_to admin_conference_conference_team_members_path(conference_id: @conference.short_title), notice: "Update of Team Member for #{@conference.short_title} failed."
      end
    end

    def up
      @conference_team_member.move_higher
      redirect_to admin_conference_conference_team_members_path(conference_id: @conference.short_title)
    end

    def down
      @conference_team_member.move_lower
      redirect_to admin_conference_conference_team_members_path(conference_id: @conference.short_title)
    end


    private

    def conference_team_member_params
      params.require(:conference_team_member).permit(:position, :conference_id, :refinery_team_member_id)
    end

    def conference_params
      params.require(:conference).permit(conference_team_member_ids: [])
    end
  end
end
