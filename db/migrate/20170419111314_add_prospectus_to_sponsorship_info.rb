class AddProspectusToSponsorshipInfo < ActiveRecord::Migration
  def change
    add_column :sponsorship_infos, :prospectus, :string
  end
end
