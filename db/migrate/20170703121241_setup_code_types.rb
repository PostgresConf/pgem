class SetupCodeTypes < ActiveRecord::Migration
  def up
      CodeType.find_or_create_by(id: 1, title: "Discount")
      CodeType.find_or_create_by(id: 2, title: "Access")
  end

  def down
    CodeType.delete_all
  end
end
