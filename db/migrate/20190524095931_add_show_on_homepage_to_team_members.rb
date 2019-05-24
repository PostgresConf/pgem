class AddShowOnHomepageToTeamMembers < ActiveRecord::Migration
  def change
    add_column :refinery_team_members, :show_on_homepage, :boolean, default: false
  end
end

