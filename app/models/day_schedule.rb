class DaySchedule

  attr_accessor :conference
  attr_accessor :room
  attr_accessor :event

  attr_accessor :interval_start
  attr_accessor :span

  def initialize(conference_id, day, interval, time)
    @conference_id = conference_id
    @day = day
    @interval = interval
    @time = time
  end

  def fetch
    if @time.blank?
      where = '1 = 1'
    else
      where = "interval_start BETWEEN ('#{@time}'::timestamp - '2 hours'::interval) and ('#{@time}'::timestamp + '2 hours'::interval)"
    end

    ActiveRecord::Base.connection.execute("SELECT conference_id, interval_start, room_id, event_id, span
      FROM get_days_schedule(#{@conference_id}, '#{@day}'::timestamp, #{@interval}) WHERE #{where}")
  end

  def save(validate = true)
    validate ? valid? : true
  end
end
