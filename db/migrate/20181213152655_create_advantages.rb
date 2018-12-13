class CreateAdvantages < ActiveRecord::Migration
  def self.up
    create_table :advantages do |t|
      t.string :name
      t.text :description
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at
      t.string :picture
      t.belongs_to :conference
      t.timestamps
    end

    add_foreign_key :advantages, :conferences
  end

  def self.down
    drop_table :advantages
  end
end
