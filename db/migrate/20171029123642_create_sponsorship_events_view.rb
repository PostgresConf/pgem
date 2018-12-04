class CreateSponsorshipEventsView < ActiveRecord::Migration
  def self.up 
    execute <<-SQL
      CREATE VIEW sponsorship_events AS
        SELECT name, start_date, end_date, event_type, event_id, sponsor_id, 
               conference_id, sponsorship_levels_benefit_id
          FROM (SELECT c.title as name, c.start_date, c.end_date, 
                       'conf' as event_type, (s.id * -1) as event_id, 
                       s.sponsor_id, c.id as conference_id,
                       null as sponsorship_levels_benefit_id
                  FROM sponsorships s, conferences c
                 WHERE s.conference_id = c.id
                 UNION
                SELECT b.name, b.due_date::date as start_date, null as end_date, 
                       'task' as event_type, b.id, s.sponsor_id, s.conference_id,
                       slb.id as sponsorship_levels_benefit_id
                  FROM sponsorships s, sponsorship_levels_benefits slb, benefits b
                 WHERE s.sponsorship_level_id = slb.sponsorship_level_id
                   AND slb.benefit_id = b.id
               ) as events
         ORDER BY start_date
    SQL
  end

  def self.down
    execute "DROP VIEW sponsorship_events"
  end
end
