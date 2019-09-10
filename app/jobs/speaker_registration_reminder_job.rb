class SpeakerRegistrationReminderJob < ActiveJob::Base
    queue_as :default
  
    def perform(conference)
        cfp = conference.program.cfp
        reminder_dates = []
        # do nothing except for nth day before reg_reminder_end date
        reminder_dates = [0, 1, 2, 3, 5, 8, 13].map {|n| cfp.reg_reminder_end-n.days} if cfp.reg_reminder_end
        if reminder_dates.include? Date.today
            if conference.email_settings.send_on_confirmed_without_registration? &&
                conference.email_settings.confirmed_without_registration_body  &&
                conference.email_settings.confirmed_without_registration_subject
                registered_user_ids = conference.registrations.pluck(:user_id)

                unregistered_speakers = EventUser.where(event: conference.program.events.where(state: 'confirmed'), event_role: 'speaker').where.not(user_id: registered_user_ids).map(&:user)
                unregistered_speakers.each do |speaker|
                    Rails.logger.info "#{self.class}@#{conference.short_title} Sending registration reminder to #{speaker.name}"
                    Mailbot.confirm_reminder_mail(self, speaker).deliver_later
                end
            end
        else
            Rails.logger.info "#{self.class}@#{conference.short_title} nothing to do today"
        end
        # for conferences which have their reg_reminder_end set, either reschedule conference to the next day, or terminate the job
        if cfp.reg_reminder_end
            if Date.today < cfp.reg_reminder_end
                retry_job wait_until: Date.tomorrow.midnight
                Rails.logger.info "#{self.class}@#{conference.short_title} job rescheduled"
            else
                Rails.logger.info "#{self.class}@#{conference.short_title} job terminated"
            end
        end
    end
  end
  