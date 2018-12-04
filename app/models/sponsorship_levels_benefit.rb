class SponsorshipLevelsBenefit < ActiveRecord::Base
  belongs_to :sponsorship_level
  belongs_to :benefit
  belongs_to :code_type

  def self.level_promo_codes(sponsorship)
    SponsorshipLevelsBenefit.where(sponsorship_level_id: sponsorship.sponsorship_level_id).joins(:benefit).where("benefits.value_type = 3")
  end
end
