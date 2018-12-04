class CreateTicketGroups < ActiveRecord::Migration
  def self.up
    create_table :ticket_groups do |t|
      t.references :conference
      t.string :name
      t.string :description
      t.integer :position
      t.text :additional_details

      t.timestamps
    end

    add_index :ticket_groups, :conference_id

    add_foreign_key :ticket_groups, :conferences
  end

  def self.down
    drop_table :ticket_groups
  end
end

