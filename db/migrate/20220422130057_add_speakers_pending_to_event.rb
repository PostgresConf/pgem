class AddSpeakersPendingToEvent < ActiveRecord::Migration
  def change
    add_column :events, :speakers_pending, :boolean, defaut: false
  end
end
