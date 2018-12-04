class SchedulesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :respond_to_options
  load_and_authorize_resource :conference, find_by: :short_title
  load_resource :program, through: :conference, singleton: true, except: :index
  load_resource :room, find_by: :id, only: [:room, :now]

  def show
    @rooms = @conference.venue.rooms if @conference.venue
    schedules = @program.selected_event_schedules
    unless schedules
      redirect_to events_conference_schedule_path(@conference.short_title)
    end

    @events_schedules = schedules
    @events_xml = schedules.map(&:event).group_by{ |event| event.time.to_date } if schedules
    @dates = @conference.start_date..@conference.end_date
    @tracks = @conference.program.tracks

    @step_minutes = EventType::LENGTH_STEP.minutes
    @conf_start = @conference.start_hour
    @conf_end = @conference.end_hour
    @conf_period = @conference.end_hour - @conf_start

    # the schedule takes you to today if it is a date of the schedule
    @current_day = @conference.current_conference_day
    @day = @current_day.present? ? @current_day : @dates.first
    return unless @current_day
    # the schedule takes you to the current time if it is beetween the start and the end time.
    @hour_column = @conference.hours_from_start_time(@conf_start, @conference.end_hour)

    @tzname = Time.now.in_time_zone(@conference.timezone).strftime('%Z')
  end

  def mobile
    @rooms = @conference.venue.rooms if @conference.venue
    schedules = @program.selected_event_schedules
    unless schedules
      redirect_to events_conference_schedule_path(@conference.short_title)
    end

    @events_schedules = schedules
    @events_xml = schedules.map(&:event).group_by{ |event| event.time.to_date } if schedules
    @dates = @conference.start_date..@conference.end_date
    @tracks = @conference.program.tracks

    @step_minutes = EventType::LENGTH_STEP.minutes
    @conf_start = @conference.start_hour
    @conf_end = @conference.end_hour
    @conf_period = @conference.end_hour - @conf_start

    # the schedule takes you to today if it is a date of the schedule
    @current_day = @conference.current_conference_day
    @day = @current_day.present? ? @current_day : @dates.first
    return unless @current_day
    # the schedule takes you to the current time if it is beetween the start and the end time.
    @hour_column = @conference.hours_from_start_time(@conf_start, @conference.end_hour)

    @tzname = Time.now.in_time_zone(@conference.timezone).strftime('%Z')
  end

  def today_events
    day = Time.find_zone(@conference.timezone).today
    @current_time = Time.current.in_time_zone(@conference.timezone)
    @today_event_schedules = []
    @today_event_schedules = @program.selected_event_schedules.where(
      start_time: day + @conference.start_hour.hours..@current_time + 2.hours) if @program.selected_schedule
    render partial: 'today_events'
  end

  def room
    if params[:id].nil?
      redirect_to events_conference_schedule_path(@conference.short_title)
    else
      @room = Room.find_by(id: params[:id])
    end

    offset = ActiveSupport::TimeZone.seconds_to_utc_offset(ActiveSupport::TimeZone[@conference.timezone].utc_offset)

    if params[:date].nil? || params[:time].nil?
      @day = Time.find_zone(@conference.timezone).today
      @current_time = Time.current.in_time_zone(@conference.timezone)
    else
      @day = DateTime.parse(params[:date])
      @current_time = DateTime.parse(params[:date] + ' ' + params[:time] + ' ' + offset)
    end

    conf_start_utc = DateTime.new(@day.year, @day.mon, @day.day, @conference.start_hour, 0, 0, offset)
    conf_end_utc = DateTime.new(@day.year, @day.mon, @day.day, @conference.end_hour, 0, 0, offset)
    @today_event_schedules = []
    @today_event_schedules = @program.selected_event_schedules.where(
      start_time: conf_start_utc..conf_end_utc,
      room_id: @room.id) if @program.selected_schedule

    response.headers.delete "X-Frame-Options"
    render layout: "signage"

  end

  def now
    if params[:id].nil?
      redirect_to events_conference_schedule_path(@conference.short_title)
    else
      @room = Room.find_by(id: params[:id])
    end

    offset = ActiveSupport::TimeZone.seconds_to_utc_offset(ActiveSupport::TimeZone[@conference.timezone].utc_offset)

    if params[:date].nil? || params[:time].nil?
      @day = Time.find_zone(@conference.timezone).today
      @current_time = Time.current.in_time_zone(@conference.timezone)
    else
      @day = DateTime.parse(params[:date])
      @current_time = DateTime.parse(params[:date] + ' ' + params[:time] + ' ' + offset)
    end

    @upcoming_event = @program.selected_event_schedules
      .where('get_event_time_range(event_schedules.schedule_id, event_schedules.event_id)  @> ?::timestamp and room_id = ?', @current_time,@room.id)
      .order(:start_time).first if @program.selected_schedule

    response.headers.delete "X-Frame-Options"
    render layout: "signage"
  end

  def today
    offset = ActiveSupport::TimeZone.seconds_to_utc_offset(ActiveSupport::TimeZone[@conference.timezone].utc_offset)

    if params[:date].nil?
      @day = Time.find_zone(@conference.timezone).today
    else
      @day = DateTime.parse(params[:date])
    end

    if params[:time].nil?
      @current_time = DateTime.parse(@day.strftime('%Y/%m/%d') + ' ' + Time.current.strftime('%X'))
    else
      @current_time = DateTime.parse(params[:date] + ' ' + params[:time] + ' ' + offset)
    end


    @rooms = @conference.venue.rooms if @conference.venue
    schedules = @program.selected_event_schedules
    unless schedules
      redirect_to events_conference_schedule_path(@conference.short_title)
    end

    @events_schedules = schedules
    @dates = @conference.start_date..@conference.end_date
    @tracks = @conference.program.tracks

    @step_minutes = EventType::LENGTH_STEP.minutes
    @conf_start = @conference.start_hour
    @conf_end = @conference.end_hour
    @conf_period = @conference.end_hour - @conf_start

    # the schedule takes you to today if it is a date of the schedule
    @current_day = @day

    @events_schedules = schedules
    response.headers.delete "X-Frame-Options"
    render layout: "signage"

  end

  def events
    @dates = @conference.start_date..@conference.end_date
    @tracks = @conference.program.tracks

    @events_schedules = @program.selected_event_schedules
    @events_schedules = [] unless @events_schedules

    @unscheduled_events = if @program.selected_schedule
                            @program.events.confirmed - @program.selected_schedule.events
                          else
                            @program.events.confirmed
                          end

    day = @conference.current_conference_day
    @tag = day.strftime('%Y-%m-%d') if day
  end

  def ical
    schedules = @program.selected_event_schedules

    @cal = Icalendar::Calendar.new
    @cal.prodid = Icalendar::Values::Text.new(@conference.title)

    schedules.each do |schedule|
      e = schedule.event
      event = Icalendar::Event.new
      event.dtstart = Icalendar::Values::DateTime.new(e.time, 'tzid' => 'UTC')
      event.dtend = Icalendar::Values::DateTime.new(e.end_time, 'tzid' => 'UTC')

      if e.event_type.internal_event
        event.summary = Icalendar::Values::Text.new(e.title)
      else
        event.summary = Icalendar::Values::Text.new(e.title + " (" + e.speaker_names + ")")
      end

      event.location = Icalendar::Values::Text.new(e.room.name)
      event.url = Icalendar::Values::Uri.new(url_for(conference_program_proposal_url(@conference.short_title, e.id)))

      @cal.add_event(event)
    end

    send_data @cal.to_ical, :filename => @conference.short_title + '.ics'
  end

  private

  def respond_to_options
    respond_to do |format|
      format.html { head :ok }
    end if request.options?
  end
end
