class ConferencesCode < ActiveRecord::Base
  belongs_to :conference
  belongs_to :code
end
