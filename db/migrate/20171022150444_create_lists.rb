class CreateLists < ActiveRecord::Migration[5.0]
  def change
    create_table :lists do |t|
      t.string :name
      t.string :description

      t.index :name, unique: true
      t.timestamps
    end
  end
end
