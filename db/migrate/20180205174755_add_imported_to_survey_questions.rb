class AddImportedToSurveyQuestions < ActiveRecord::Migration
  def self.up
    change_table(:survey_questions) do |t|
      t.boolean :imported, :default => false
    end

  end

  def self.down
    remove_column :survey_questions, :imported
  end
end
