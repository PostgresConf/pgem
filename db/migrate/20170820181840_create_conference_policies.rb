class CreateConferencePolicies < ActiveRecord::Migration
  def self.up
    create_table :conferences_policies, id: false do |t|
      t.references :conference
      t.references :policy
    end

    add_index :conferences_policies, [:conference_id, :policy_id], :unique => true

    add_foreign_key :conferences_policies, :conferences
    add_foreign_key :conferences_policies, :policies
  end

  def self.down
    drop_table :conferences_policies
  end
end
