class CreateGetEventTimeRangeFunction < ActiveRecord::Migration
 def self.up
    execute <<-__EOI
CREATE OR REPLACE FUNCTION get_event_time_range(p_schedule_id int, p_event_id int, padding int DEFAULT 0)
  RETURNS tsrange AS
$$
  SELECT tsrange(es.start_time - (padding || ' minute')::interval, es.start_time + (et.length || ' minute')::interval)
    FROM events e, event_types et, event_schedules es
   WHERE es.event_id = e.id
     AND e.event_type_id = et.id
     AND es.schedule_id = p_schedule_id
     AND e.id = p_event_id;
$$ LANGUAGE sql;
    __EOI
  end

  def self.down
    execute <<-__EOI
    DROP FUNCTION get_event_time_range(int, int, int);
    __EOI
  end

end
