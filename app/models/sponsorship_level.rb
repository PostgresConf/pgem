class SponsorshipLevel < ActiveRecord::Base
  validates_presence_of :title
  belongs_to :conference
  acts_as_list scope: :conference
  has_many :sponsorships
  has_many :sponsorship_levels_benefits

  has_and_belongs_to_many :benefits, :join_table => :sponsorship_levels_benefits

  default_scope { order(position: :asc) }

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }
end
