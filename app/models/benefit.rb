class Benefit < ActiveRecord::Base
  belongs_to :conference

  has_and_belongs_to_many :sponsorship_levels, :join_table => :sponsorship_levels_benefits

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }

  validates :name, presence: true

  enum category: [:general, :digital, :physical]
  enum value_type: [:main_url, :main_logo, :main_description, :promo_code, :text, :file, :boolean]

  def self.find_by_parameterize_name(conference, name)
    lower_name = name.humanize.downcase
    Benefit.where('conference_id = ? and lower(name) = ?', conference.id, lower_name).first
  end
end
