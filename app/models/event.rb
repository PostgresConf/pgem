class Event < ActiveRecord::Base
  include ActiveRecord::Transitions
  has_paper_trail on: [:create, :update], ignore: [:updated_at, :guid, :week], meta: { conference_id: :conference_id }

  acts_as_commentable
  acts_as_taggable

  after_create :set_week

  has_many :event_users, dependent: :destroy
  has_many :users, through: :event_users

  has_many :speaker_event_users, -> { where(event_role: 'speaker') }, class_name: 'EventUser'
  has_many :speakers, through: :speaker_event_users, source: :user

  has_one :submitter_event_user, -> { where(event_role: 'submitter') }, class_name: 'EventUser'
  has_one  :submitter, through: :submitter_event_user, source: :user

  has_many :speaker_invitations
  validates_length_of :speaker_invitations, maximum: 5

  has_many :involved, -> { distinct }, through: :event_users, source: :user

  has_many :ticket_purchases
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user
  has_many :commercials, as: :commercialable, dependent: :destroy
  belongs_to :event_type

  has_many :events_registrations
  has_many :registrations, through: :events_registrations
  has_many :event_schedules, dependent: :destroy

  belongs_to :track
  belongs_to :difficulty_level
  belongs_to :program
  belongs_to :ticket

  accepts_nested_attributes_for :event_users, allow_destroy: true
  accepts_nested_attributes_for :speakers, allow_destroy: true
  accepts_nested_attributes_for :users

  before_create :generate_guid
  after_update :sync_with_schedule_integration

  validate :abstract_limit
  validate :before_end_of_conference, on: :create
  validates :title, presence: true
  validates :abstract, presence: true, unless: "event_type.internal_event"
  validates :event_type, presence: true
  validates :program, presence: true
  validates :speakers, presence: true
  validates :max_attendees, numericality: { only_integer: true, greater_than_or_equal_to: 1, allow_nil: true }

  validate :max_attendees_no_more_than_room_size

  mount_uploader :document, DocumentUploader

  scope :confirmed, -> { where(state: 'confirmed') }
  scope :canceled, -> { where(state: 'canceled') }
  scope :withdrawn, -> { where(state: 'withdrawn') }
  scope :highlighted, -> { where(is_highlight: true) }

  state_machine initial: :new do
    state :new
    state :withdrawn
    state :unconfirmed
    state :confirmed
    state :canceled
    state :rejected

    event :restart do
      transitions to: :new, from: [:rejected, :withdrawn, :canceled]
    end
    event :withdraw do
      transitions to: :withdrawn, from: [:new, :unconfirmed, :confirmed]
    end
    event :accept do
      transitions to: :unconfirmed, from: [:new], on_transition: :process_acceptance
    end
    event :confirm do
      transitions to: :confirmed, from: :unconfirmed, on_transition: :process_confirmation
    end
    event :cancel do
      transitions to: :canceled, from: [:unconfirmed, :confirmed]
    end
    event :reject do
      transitions to: :rejected, from: [:new], on_transition: :process_rejection
    end
  end

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history, :finders]

  ##
  # Checkes if the event has a start_time and a room for the selected schedule if there is any
  # ====Returns
  # * +true+ or +false+
  def scheduled?
    event_schedules.find_by(schedule_id: program.selected_schedule_id).present?
  end

  def registration_possible?
    return false unless require_registration && state == 'confirmed'
    return true if max_attendees.nil?
    registrations.count < max_attendees
  end

  ##
  # Finds the rating of the user for the event
  # ====Returns
  # * +integer+ -> the rating of the user for the event
  def user_rating(user)
    (vote = votes.find_by(user: user)) ? vote.rating : 0
  end

  ##
  # Checks if the event has votes
  # If a user is provided, it checks if the event has votes by the user
  # ====Returns
  # * +true+ -> If the event has votes (optionally, by the user)
  # * +false+ -> If the event does not have any votes (optionally, by the user)
  def voted?(user=nil)
    return votes.where(user: user).any? if user

    votes.any?
  end

  def average_rating
    @total_rating = 0
    votes.each do |vote|
      @total_rating = @total_rating + vote.rating
    end
    @total = votes.size
    @total_rating > 0 ? number_with_precision(@total_rating / @total.to_f, precision: 2, strip_insignificant_zeros: true) : 0
  end

  # get event speakers with the event sumbmitter at the first position
  # if the submitter is also a speaker for this event
  def speakers_ordered
    speakers_list = speakers.to_a

    if speakers_list.reject! { |speaker| speaker == submitter }
      speakers_list.unshift(submitter)
    end

    speakers_list
  end

  def transition_possible?(transition)
    self.class.state_machine.events_for(current_state).include?(transition)
  end

  def process_confirmation(options = {})
    if program.conference.email_settings.send_on_confirmed_without_registration? &&
        program.conference.email_settings.confirmed_without_registration_body  &&
        program.conference.email_settings.confirmed_without_registration_subject
      involved.each do |recipient|
        if program.conference.registrations.where(user_id: recipient.id).first.nil?
          Mailbot.confirm_reminder_mail(self, recipient).deliver_later
        end
      end
    end
  end

  def process_acceptance(options)
    if program.conference.email_settings.send_on_accepted &&
        program.conference.email_settings.accepted_body &&
        program.conference.email_settings.accepted_subject &&
        !options[:send_mail].blank?
      involved.each do |recipient|
        Mailbot.acceptance_mail(self, recipient).deliver_later
      end
    end
  end

  def process_rejection(options)
    if program.conference.email_settings.send_on_rejected &&
        program.conference.email_settings.rejected_body &&
        program.conference.email_settings.rejected_subject &&
        !options[:send_mail].blank?
      involved.each do |recipient|
        Mailbot.rejection_mail(self, recipient).deliver_later
      end
    end
  end

  def abstract_word_count
    abstract.to_s.split.size
  end

  def self.get_state_color(state)
    color = {
      new:         '#0000FF', # blue
      withdrawn:   '#FF8000', # orange
      confirmed:   '#00FF00', # green
      unconfirmed: '#FFFF00', # yellow
      rejected:    '#FF0000', # red
      canceled:    '#848484'  # grey
    }[state.to_sym]

    color || '#00FFFF' # azure
  end

  def update_state(transition, mail = false, subject = false, send_mail = false, send_mail_param)
    alert = ''
    if mail && send_mail_param && subject && send_mail
      alert = 'Update Email Subject before Sending Mails'
    end
      begin
        if mail
          self.send(transition,
                    send_mail: send_mail_param)
        else
          self.send(transition)
        end
        self.save
      rescue Transitions::InvalidTransition => e
        alert = "Update state failed. #{e.message}"
      end
    alert
  end

  def speaker_names
    result = Set.new
    speakers.each do |speaker|
      result.add(speaker.name)
    end
    result.to_a.to_sentence
  end

  def invitations_left
    5 - self.speaker_invitations.count
  end

  def pending_invitations
    self.speaker_invitations.where.not(accepted: true)
  end

  ##
  #
  # Returns +Hash+
  def progress_status
    {
      registered:       speakers.all? { |speaker| program.conference.user_registered? speaker },
      biographies:      speakers.all? { |speaker| !speaker.biography.blank? },
      subtitle:         !self.subtitle.blank?,
      track:            (!self.track.blank? unless self.program.tracks.empty?),
      difficulty_level: !self.difficulty_level.blank?,
      title: true,
      abstract: true
    }.with_indifferent_access
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

  ##
  # Returns the room in which the event is scheduled
  #
  def room
    # We use try(:selected_schedule_id) because this function is used for
    # validations so program could not be present there
    event_schedules.find_by(schedule_id: program.try(:selected_schedule_id)).try(:room)
  end

  ##
  # Returns the start time at which this event is scheduled
  #
  def time
    event_schedules.find_by(schedule_id: program.selected_schedule_id).try(:start_time)
  end

  ##
  # Returns the end time at which this event is scheduled
  #
  def end_time
    t = event_schedules.find_by(schedule_id: program.selected_schedule_id).try(:start_time)
    t + (event_type.length * 60)
  end

  def active_schedule
    event_schedules.find_by(schedule_id: program.selected_schedule_id)
  end

  def ended?
    return false unless self.end_time
    self.end_time < Date.today
  end

  # This will return the maximum number of tickets available within one purchase
  def purchase_quantity_available
    if max_attendees.blank?
      10
    else
      purchased = EventsRegistration.where(event_id: self.id).count
      max_attendees - purchased
    end
  end

  def attendees
    User.where(id: self.registrations.pluck(:id))
  end

  private

  ##
  # Do not allow, for the event, more attendees than the size of the room
  def max_attendees_no_more_than_room_size
    return unless room && max_attendees_changed?
    errors.add(:max_attendees, "cannot be more than the room's capacity (#{room.size})") if max_attendees && (max_attendees > room.size)
  end

  def abstract_limit
    #dont validate abstract for internal events
    return if event_type.internal_event
    # If we don't have an event type, there is no need to count anything
    return unless event_type && abstract
    len = abstract.split.size
    max_words = event_type.maximum_abstract_length
    min_words = event_type.minimum_abstract_length

    errors.add(:abstract, "cannot have less than #{min_words} words") if len < min_words
    errors.add(:abstract, "cannot have more than #{max_words} words") if len > max_words
  end

  # TODO: create a module to be mixed into model to perform same operation
  # venue.rb has same functionality which can be shared
  # TODO: rename guid to UUID as guid is specifically Microsoft term
  def generate_guid
    loop do
      @guid = SecureRandom.urlsafe_base64
      break unless self.class.where(guid: guid).any?
    end
    self.guid = @guid
  end

  def set_week
    self.week = created_at.strftime('%W')
    self.without_versioning do
      self.save!
    end
  end

  def before_end_of_conference
    errors.
        add(:created_at, "can't be after the conference end date!") if program.conference && program.conference.end_date &&
        (Date.today > program.conference.end_date)
  end

  def conference_id
    program.conference_id
  end

  def sync_with_schedule_integration
    es = EventSchedule.where(event_id: self.id).first

    unless es.blank?
      ##
      # Check if there are any integrations that require an update
      ##
      integrations = Integration.where(conference_id: program.conference_id)
      integrations.each do |integration|
        integration.update_event(self)
      end
    end
  end

end
