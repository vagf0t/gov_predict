class CreateListsOfPeople < ActiveRecord::Migration[5.0]
  def change
    create_join_table :lists, :people do |t|
      t.index :list_id
      t.index :person_id
      t.timestamps
    end
  end
end
