class Ahoy::Visit < ActiveRecord::Base
  self.table_name = "ahoy_visits"

  has_many :ahoy_events, class_name: "Ahoy::Event"
  belongs_to :user, optional: true
end
