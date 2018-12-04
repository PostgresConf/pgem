class EventUser < ActiveRecord::Base
  # TODO Do we need these roles?
  ROLES = [['Speaker', 'speaker'], ['Submitter', 'submitter'], ['Moderator', 'moderator']]

  belongs_to :event
  belongs_to :user

  def self.set_is_highlight(program, user, is_highlight)
    ActiveRecord::Base.connection.execute("UPDATE event_users SET is_highlight = #{ActiveRecord::Base.sanitize(is_highlight)} FROM events WHERE event_users.event_id = events.id AND events.program_id = #{ActiveRecord::Base.sanitize(program.id)} AND event_users.user_id = #{ActiveRecord::Base.sanitize(user.id)}")
  end
end
