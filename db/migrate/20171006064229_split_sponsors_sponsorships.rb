class SplitSponsorsSponsorships < ActiveRecord::Migration
  def change
    execute <<-SQL.squish
        DO $$
        DECLARE
          r      record;
          l_id   int;
          l_desc sponsors.description%type;
          l_ws   sponsors.website_url%type;
          l_logo sponsors.logo_file_name%type;
          l_pict sponsors.picture%type;

        BEGIN
            DROP TABLE IF EXISTS s;

            CREATE TEMP TABLE s AS
              SELECT DISTINCT id, name 
                FROM (SELECT name, FIRST_VALUE(id) OVER w AS id
                        FROM sponsors
                      WINDOW w AS (PARTITION BY name ORDER BY updated_at DESC)) a;

            FOR r IN SELECT * FROM sponsors LOOP
                SELECT id
                  INTO l_id
                  FROM s
                 WHERE name = r.name;

                INSERT INTO sponsorships (conference_id, sponsor_id, sponsorship_level_id, created_at, updated_at)
                   VALUES (r.conference_id, l_id, r.sponsorship_level_id, now(), now());
            END LOOP;

            FOR r IN SELECT * FROM s LOOP
                SELECT max(description), max(website_url), max(logo_file_name), max(picture)
                  INTO l_desc, l_ws, l_logo, l_pict
                  FROM sponsors
                 WHERE name = r.name;

                UPDATE sponsors
                   SET description = l_desc,
                       website_url = l_ws,
                       logo_file_name = l_logo, 
                       picture = l_pict
                 WHERE id = r.id;
            END LOOP;

            UPDATE codes
               SET sponsor_id = null
             WHERE sponsor_id IS NOT NULL;

            DELETE FROM sponsors
             WHERE id NOT IN (SELECT id FROM s);
        END
        $$;      
    SQL
  end
end
