class CreateBoomsetTicketConfig < ActiveRecord::Migration
  def self.up
    create_table :boomset_ticket_configs do |t|
      t.belongs_to :conference
      t.belongs_to :integration
      t.belongs_to :ticket
      t.integer :boomset_registration_type
      t.timestamps
    end

    add_foreign_key :boomset_ticket_configs, :conferences
    add_foreign_key :boomset_ticket_configs, :integrations
    add_foreign_key :boomset_ticket_configs, :tickets

    add_index :boomset_ticket_configs, [:conference_id, :ticket_id, :integration_id], unique: true, :name => :bs_conf_tix_int_idx
  end

  def self.down
    drop_table :boomset_ticket_configs
  end
end
