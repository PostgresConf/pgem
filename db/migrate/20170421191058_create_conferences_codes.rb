class CreateConferencesCodes < ActiveRecord::Migration
  def self.up
    create_table :conferences_codes, id: false do |t|
      t.references :conference
      t.references :code
    end

    add_index :conferences_codes, [:conference_id, :code_id], :unique => true

    add_foreign_key :conferences_codes, :conferences
    add_foreign_key :conferences_codes, :codes
  end

  def self.down
    drop_table :conferences_codes
  end
end
