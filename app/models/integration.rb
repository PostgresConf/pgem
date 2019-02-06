class Integration < ActiveRecord::Base
  belongs_to :conference

  enum integration_type: [:boomset, :mailchimp]

  validates :integration_type, presence: true
end
