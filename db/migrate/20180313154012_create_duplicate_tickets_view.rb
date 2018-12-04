class CreateDuplicateTicketsView < ActiveRecord::Migration
  def self.up
    execute <<-SQL
      CREATE VIEW duplicate_tickets AS
        SELECT tp.conference_id AS conference_id, 
               pt.user_id AS user_id, 
               tp.ticket_id AS ticket_id, 
               count(*) AS ticket_count, 
               string_agg(pt.pending_assignment, ',') AS pending_assignments
          FROM physical_tickets pt, ticket_purchases tp
         WHERE pt.ticket_purchase_id = tp.id
         GROUP BY 1, 2, 3
        HAVING count(*) > 1
         ORDER BY 4 DESC
    SQL
  end

  def self.down
    execute "DROP VIEW duplicate_tickets"
  end
end
