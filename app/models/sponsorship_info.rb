class SponsorshipInfo < ActiveRecord::Base
  belongs_to :conference
  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }
  validates :description, presence: true

  mount_uploader :prospectus, DocumentUploader
  mount_uploader :manual, DocumentUploader
end
