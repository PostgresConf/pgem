class Sponsorship < ActiveRecord::Base
  belongs_to :sponsorship_level
  belongs_to :conference
  belongs_to :sponsor

  has_many :benefit_responses

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }

  delegate :name, to: :sponsor
  delegate :description, to: :sponsor
  delegate :website_url, to: :sponsor
  delegate :logo_file_name, to: :sponsor
  delegate :picture, to: :sponsor
  delegate :title, to: :sponsorship_level

  def progress_status
    status = {
      company_name: !self.sponsor.name.blank?
    }.with_indifferent_access

    Sponsorship.level_benefits(self.sponsorship_level_id).each do |slb|
      case slb.benefit.value_type
      when 'main_url'
        status[slb.benefit.name.parameterize('_')] = !self.sponsor.website_url.blank?
      when 'main_logo'
        status[slb.benefit.name.parameterize('_')] = !self.sponsor.logo_file_name.blank?
      when 'main_description'
        status[slb.benefit.name.parameterize('_')] = !self.sponsor.description.blank?
      when 'promo_code'
        status[slb.benefit.name.parameterize('_')] = check_code_usage(slb)
      else
        status[slb.benefit.name.parameterize('_')] = check_response(slb)
      end
    end

    status
  end

  ##
  # Returns the progress of the proposal's set up
  #
  # ====Returns
  # * +String+ -> Progress in Percent
  def calculate_progress
    result = self.progress_status
    (100 * result.values.count(true) / result.values.compact.count).to_s
  end

  def self.find_sponsorship(conference, sponsor)
    Sponsorship.where(conference_id: conference.id, sponsor_id: sponsor.id).first
  end
  private

  def self.level_benefits(level_id)
    SponsorshipLevelsBenefit.where(sponsorship_level_id: level_id).joins(:benefit).order('benefits.due_date')
  end

  def self.create_sponsorship(sponsorship)
    conference = Conference.find(sponsorship.conference_id)
    sponsor = Sponsor.find(sponsorship.sponsor_id)

    ActiveRecord::Base.transaction do
      lpcs = SponsorshipLevelsBenefit.level_promo_codes(sponsorship)
      lpcs.each do |lpc|
        code = conference.codes.new
        code.conference = conference
        code.sponsor = sponsor
        code.code_type_id = lpc.code_type_id

        if lpc.discount.nil?
          code.discount = 0
        else
          code.discount = lpc.discount
        end

        unless lpc.max_uses.nil?
          code.max_uses = lpc.max_uses
        end

        if lpc.code_type_id == 2
          code.name = "SPONSOR_" + conference.short_title.upcase + "_" + sponsor.short_name.upcase
        else
          code.name = conference.short_title.upcase + "_" + sponsor.short_name.upcase
        end

        code.save!
        ConferencesCode.create :conference => conference, :code => code
      end
      sponsorship.save!
    end
  end

  private

  def check_code_usage(slb)
    used = false

    codes = Code.where(sponsor_id: sponsor.id, code_type_id: slb.code_type_id)
    codes.each do |code|
      if TicketPurchase.get_code_usage(conference, code) > 0
        used = true
      end
      break if used
    end

    used
  end

  def check_response(slb)
    BenefitResponse.where(conference_id: conference.id, sponsorship_id: id, benefit_id: slb.benefit_id).exists?
  end
end
