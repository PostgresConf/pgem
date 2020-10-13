class CreateSpeakerInvitations < ActiveRecord::Migration
  def change
    create_table :speaker_invitations do |t|
      t.references :event, index: true, foreign_key: true
      t.string :email
      t.string :token
      t.boolean :accepted, default: false, null: false
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
