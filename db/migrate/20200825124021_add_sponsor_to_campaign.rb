class AddSponsorToCampaign < ActiveRecord::Migration
  def change
    add_reference :campaigns, :sponsor, index: true, foreign_key: true
  end
end
