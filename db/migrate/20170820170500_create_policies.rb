class CreatePolicies < ActiveRecord::Migration
  def self.up
    create_table :policies do |t|
      t.string     :title
      t.references :conference
      t.boolean    :global
      t.text       :description
      t.timestamps
    end

    add_foreign_key :policies, :conferences
  end

  def self.down
    drop_table :policies
  end
end
