class Poll < ActiveRecord::Base
  belongs_to :conference
  belongs_to :survey, :class_name => Survey::Survey

  validates :conference, :presence => true
  validates :survey, :presence => true

end
