class Policy < ActiveRecord::Base
  has_and_belongs_to_many :conferences

  validates :title, presence: true

  def code
    if title
      title.parameterize(separator: '_')
    end
  end
end
