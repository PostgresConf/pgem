class CreateTicketGroupBenefitsTickets < ActiveRecord::Migration
  def self.up
    create_table :ticket_group_benefits_tickets, id: false do |t|
      t.references :ticket_group_benefit, null: false
      t.references :ticket, null: false
    end

    add_index :ticket_group_benefits_tickets, [:ticket_group_benefit_id, :ticket_id], unique: true, :name => :tg_benefit_tix_idx

    add_foreign_key :ticket_group_benefits_tickets, :ticket_group_benefits
    add_foreign_key :ticket_group_benefits_tickets, :tickets

  end

  def self.down
    drop_table :ticket_group_benefits_tickets
  end

end
