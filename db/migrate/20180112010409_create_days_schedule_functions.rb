class CreateDaysScheduleFunctions < ActiveRecord::Migration
  def self.up
    execute <<-__EOI
    CREATE TYPE day_schedule AS (
            conference_id integer,
            interval_start timestamp without time zone,
            room_id integer,
            event_id integer,
            span integer
    );

    CREATE FUNCTION day_rooms(p_conference_id integer, p_day timestamp without time zone, OUT room_id integer) RETURNS SETOF integer
        LANGUAGE sql
        AS $$
      SELECT DISTINCT r.id
        FROM rooms r, venues v, event_schedules es
       WHERE r.venue_id = v.id
         AND es.room_id = r.id
         AND v.conference_id = p_conference_id
         AND es.start_time::date = p_day::date
       ORDER BY r.id;
    $$;

    CREATE FUNCTION get_span(p_event_id integer, p_interval integer) RETURNS integer
        LANGUAGE sql
        AS $$
       SELECT ceil(et.length/p_interval::numeric)::int AS span
         FROM events e, event_types et
        WHERE e.event_type_id = et.id
          AND e.id = p_event_id;
    $$;

    CREATE FUNCTION get_days_schedule(p_conference_id integer, p_day timestamp without time zone, p_interval integer) RETURNS SETOF day_schedule
        LANGUAGE plpgsql
        AS $$
    DECLARE
      l_schedule_id  int4;
      l_start_time   timestamp;
      l_end_time     timestamp;
      l_current      timestamp;
      l_entry        day_schedule;
      l_spans        int4[];
      l_rooms        int4[];
      l_room_count   int2;
      i              int2;
      r              record;
    BEGIN
      SELECT selected_schedule_id
        INTO l_schedule_id
        FROM programs
       WHERE conference_id = p_conference_id;

      SELECT min(start_time)
        INTO l_start_time
        FROM event_schedules
       WHERE schedule_id = l_schedule_id
         AND start_time::date = p_day::date;

      SELECT max(es.start_time + make_interval(mins => et.length))
        INTO l_end_time
        FROM event_schedules es, events e, event_types et
       WHERE es.event_id = e.id
         AND e.event_type_id = et.id
         AND es.schedule_id = l_schedule_id
         AND es.start_time::date = p_day::date;

      SELECT array_agg(room_id)
        INTO l_rooms
        FROM day_rooms(p_conference_id, p_day);

      l_room_count := array_length(l_rooms, 1);

      FOR i IN 1..(l_room_count+1) LOOP
          l_spans[i] := 0;
      END LOOP;

      l_current := l_start_time;
      LOOP
        EXIT WHEN l_current > l_end_time;

        i := 1;

        FOR r IN SELECT *
                   FROM event_schedules
                  WHERE schedule_id = l_schedule_id
                    AND start_time >= l_current
                    AND start_time < l_current + make_interval(mins => p_interval)
                  ORDER BY room_id
        LOOP
            <<ROOM_LOOP>>
            LOOP
                EXIT ROOM_LOOP WHEN (i > l_room_count OR r.room_id = l_rooms[i]);

                l_entry.conference_id := p_conference_id;
                l_entry.interval_start := l_current;
                l_entry.room_id := l_rooms[i];
                l_entry.event_id := null;

                IF l_spans[i] < 0 THEN
                    l_spans[i] := l_spans[i] + 1;
                END IF;
                l_entry.span := l_spans[i];

                RETURN NEXT l_entry;

                i := i + 1;
            END LOOP ROOM_LOOP;

            IF r.room_id = l_rooms[i] THEN
                l_entry.conference_id := p_conference_id;
                l_entry.interval_start := l_current;
                l_entry.room_id := r.room_id;
                l_entry.event_id := r.event_id;
                l_entry.span := get_span(r.event_id, p_interval);

                l_spans[i] := l_entry.span * -1;

                RETURN NEXT l_entry;
                i := i + 1;
            END IF;

        END LOOP;

        -- Fill in empty rows if there is no events in this interval
        WHILE i <= l_room_count LOOP
            l_entry.conference_id := p_conference_id;
            l_entry.interval_start := l_current;
            l_entry.room_id := l_rooms[i];
            l_entry.event_id := null;

            IF l_spans[i] < 0 THEN
                l_spans[i] := l_spans[i] + 1;
            END IF;
            l_entry.span := l_spans[i];

            RETURN NEXT l_entry;
            i := i + 1;
        END LOOP;

        l_current := l_current + make_interval(mins => p_interval);
      END LOOP;

      RETURN;
    END
    $$;
     __EOI
  end

  def self.down
    execute <<-__EOI
    DROP FUNCTION get_days_schedule(integer, timestamp, integer);
    DROP FUNCTION get_span(integer, integer);
    DROP FUNCTION day_rooms(integer, timestamp);
    DROP TYPE day_schedule;
    __EOI
  end
end
