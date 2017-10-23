class SocialMediaAccountsOfPepople < ActiveRecord::Migration[5.0]
  def change
    #This relation is implemented as many-to-many, since in rare cases an account can be passed
    #from one person to another, e.g. twitter account "The president of the U.S.A"
    create_join_table :social_media_accounts, :people, table_name: :accounts_of_people do |t|
      t.index :social_media_account_id
      t.index :person_id
      t.timestamps
    end
  end
end
