class BenefitResponse < ActiveRecord::Base
  belongs_to :conference
  belongs_to :sponsorship_level
  belongs_to :benefit

  mount_uploader :file_response, AttachmentUploader

  def self.find_by_benefit(conference, sponsorship, benefit)
    BenefitResponse.where(conference_id: conference.id, sponsorship_id: sponsorship.id, benefit_id: benefit.id).first
  end
end
