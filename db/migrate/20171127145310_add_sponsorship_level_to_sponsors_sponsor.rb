class AddSponsorshipLevelToSponsorsSponsor < ActiveRecord::Migration
  def change
    add_reference :refinery_sponsors, :sponsorship_level, index: true, foreign_key: true
  end
end
