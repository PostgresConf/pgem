class ConferenceTeamMember < ActiveRecord::Base
  belongs_to :conference
  belongs_to :refinery_team_member, :class_name => Refinery::TeamMembers::TeamMember

  acts_as_list scope: :conference
  default_scope { order(position: :asc) }
  

  delegate :fullname, to: :refinery_team_member
  delegate :photo, to: :refinery_team_member
  delegate :role, to: :refinery_team_member
  delegate :twitter, to: :refinery_team_member
  delegate :linkedin, to: :refinery_team_member
  delegate :description, to: :refinery_team_member
  
end
