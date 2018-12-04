class CreateTicketGroupBenefits < ActiveRecord::Migration
  def self.up
    create_table :ticket_group_benefits do |t|
      t.references :ticket_group, null: false
      t.string :name, null: false
      t.text :description, null: false
      t.integer :position

      t.timestamps
    end

    add_foreign_key :ticket_group_benefits, :ticket_groups
  end

  def self.down
    drop_table :ticket_group_benefits
  end
end
