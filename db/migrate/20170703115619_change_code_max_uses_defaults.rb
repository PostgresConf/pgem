class ChangeCodeMaxUsesDefaults < ActiveRecord::Migration
  def change
    change_column_default(:codes, :max_uses, 0)
    change_column_null(:codes, :max_uses, false)
  end
end
