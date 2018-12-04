class ConferenceGroup < ActiveRecord::Base
  has_many :conferences

  default_scope { order('name') }

  validates :name, presence: true, uniqueness: true
  
  def conference_count
    conferences.count
  end
  
end
