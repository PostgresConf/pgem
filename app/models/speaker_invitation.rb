class SpeakerInvitation < ActiveRecord::Base
  belongs_to :event
  belongs_to :user

  before_create :generate_token
  after_create :send_notification

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_associated :event

  def generate_token
    source=("A".."Z").to_a + (0..9).to_a
    token_string = ''
    30.times { token_string+= source[rand(source.size)].to_s }
    self.token = token_string
  end

  def send_notification
    Mailbot.invitation_mail(self).deliver_now
  end

  def accept
    invitee = User.find_by_email(self.email.downcase)
    if invitee and not self.accepted
      event = self.event
      if event.speakers_pending?
        # remove submitter from the speakers list
        event.speakers = event.speakers.to_a.reject! {|speaker| speaker==event.submitter}
        event.speakers_pending = false
      end
      event.speakers << invitee
      event.save
      self.user = invitee
      self.accepted = true
      self.save
      return true
    end
    self.errors.add(:base, "invitation is already accepted") if self.accepted
    self.errors.add(:base, "no user exist for this invitation. How did you get here?") unless invitee
    false
  end
end
