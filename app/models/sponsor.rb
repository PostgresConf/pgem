class Sponsor < ActiveRecord::Base
  rolify

  has_and_belongs_to_many :users

  has_many :sponsorships
  has_many :sponsors_users
  has_many :users, through: :sponsors_users, dependent: :destroy
  has_many :sponsorship_events

  mount_uploader :picture, PictureUploader, mount_on: :logo_file_name

  validates_presence_of :name, :website_url

  def self.ordered
    sponsors = Sponsor.order(:name)
    sponsors
  end

  def upcoming_sponsorships
    self.sponsorships.joins(:conference).where("DATE(conferences.end_date) >= ?", Date.today).order("conferences.end_date")
  end
end
