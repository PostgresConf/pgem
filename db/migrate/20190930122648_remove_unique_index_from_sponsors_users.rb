class RemoveUniqueIndexFromSponsorsUsers < ActiveRecord::Migration
  def change
    remove_index('sponsors_users', name: 'index_sponsors_users_on_user_id')
  end
end
