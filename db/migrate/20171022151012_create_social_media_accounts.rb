class CreateSocialMediaAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :social_media_accounts do |t|
      t.string :user_id
      t.boolean :active, default: true
      t.index :user_id

      t.timestamps
    end
    add_reference :social_media_accounts, :social_media_type, foreign_key: true, null: false
    add_reference :social_media_accounts, :person, foreign_key: true, null: false
  end
end
