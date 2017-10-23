class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.datetime :posted_at
      t.string :content
      t.string :url
      t.string :original_url

      t.timestamps
    end
    add_reference :posts, :person, foreign_key: true, null: false
    add_reference :posts, :social_media_account, foreign_key: true, null: false
  end
end
