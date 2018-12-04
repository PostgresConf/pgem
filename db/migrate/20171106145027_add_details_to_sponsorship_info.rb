class AddDetailsToSponsorshipInfo < ActiveRecord::Migration
  def change
    add_column :sponsorship_infos, :liaison_email, :string
    add_column :sponsorship_infos, :manual, :string
  end
end
