class CreateSponsorshipLevelsBenefits < ActiveRecord::Migration
  def self.up
    create_table :sponsorship_levels_benefits do |t|
      t.references :sponsorship_level
      t.references :benefit
      t.references :code_type
      t.integer    :max_uses
      t.integer    :discount

      t.timestamps
    end

    add_index :sponsorship_levels_benefits, [:sponsorship_level_id]

    add_foreign_key :sponsorship_levels_benefits, :sponsorship_levels
    add_foreign_key :sponsorship_levels_benefits, :benefits
  end

  def self.down
    drop_table :sponsorship_levels_benefits
  end
end
