class CreateBenefitResponses < ActiveRecord::Migration
  def self.up
    create_table :benefit_responses do |t|
      t.references :conference
      t.references :sponsorship
      t.references :benefit

      t.text :text_response
      t.string :file_response
      t.boolean :bool_response

      t.timestamps null: false
    end

    add_index :benefit_responses, [:conference_id, :sponsorship_id, :benefit_id], :unique => true, name: 'conf_sponsorship_benefit_idx'

    add_foreign_key :benefit_responses, :conferences
    add_foreign_key :benefit_responses, :sponsorships
    add_foreign_key :benefit_responses, :benefits

  end
end
