class CreateBenefits < ActiveRecord::Migration
  def self.up
    create_table :benefits do |t|
      t.string :name
      t.references :conference
      t.integer :category
      t.integer :value_type
      t.text :description
      t.timestamp :due_date

      t.timestamps
    end

    add_index :benefits, :conference_id

    add_foreign_key :benefits, :conferences
  end

  def self.down
    drop_table :benefits
  end
end
