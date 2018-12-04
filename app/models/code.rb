class Code < ActiveRecord::Base
  belongs_to :conference
  belongs_to :code_type
  has_and_belongs_to_many :conferences, :join_table => :conferences_codes

  has_and_belongs_to_many :tickets, :join_table => :codes_tickets
  belongs_to :sponsor

  has_many :ticket_purchases
  has_many :code_users, -> { distinct }, through: :ticket_purchases, source: :user

  validates :name, :code_type_id, presence: true
  validates :max_uses, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 100}

  def self.sponsor_codes(conference, sponsor)
    Code.where(conference_id: conference.id, sponsor_id: sponsor.id)
  end

  def self.get_discount(code_id, ticket_id)
    code = Code.find(code_id)
    if code.code_type_id = 1
      if code.tickets.where('codes_tickets.ticket_id = ?', ticket_id).exists?
        discount = code.discount.to_s + '%'
      else
        discount = ''
      end
    else
      discount = ''
    end
    discount
  end
end
