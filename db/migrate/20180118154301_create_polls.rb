class CreatePolls < ActiveRecord::Migration
  def up
    create_table :polls do |t|
      t.references :conference
      t.references :survey
      t.text :comment
      t.timestamps
    end

    add_index :polls, :conference_id

    add_foreign_key :polls, :conferences
    add_foreign_key :polls, :survey_surveys, column: :survey_id

  end

  def down
    drop_table :polls
  end
end
