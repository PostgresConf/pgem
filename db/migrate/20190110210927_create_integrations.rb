class CreateIntegrations < ActiveRecord::Migration
  def self.up
    create_table :integrations do |t|
      t.belongs_to :conference
      t.integer :integration_type
      t.string :key
      t.string :url
      t.string :integration_config_key
      t.timestamps
    end

    add_foreign_key :integrations, :conferences

    add_index :integrations, [:conference_id, :integration_type], unique: true
  end

  def self.down
    drop_table :integrations
  end
end
