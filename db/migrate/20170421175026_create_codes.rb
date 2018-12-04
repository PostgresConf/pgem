class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.string :name
      t.references :code_type
      t.integer :conference_id
      t.integer :discount
      t.integer :max_uses
      t.references :sponsor

      t.timestamps
    end

    add_index :codes, :conference_id
    add_index :codes, :name, :unique => true
    add_index :codes, :sponsor_id

    add_foreign_key :codes, :code_types
    add_foreign_key :codes, :conferences
    add_foreign_key :codes, :sponsors
  end

  def self.down
    drop_table :codes
  end
end
