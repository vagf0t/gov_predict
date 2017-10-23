class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :surname
      t.string :street_number
      t.string :street
      t.string :zip_code
      t.string :state
      t.string :city
      t.string :phone
      t.string :cellphone

      t.timestamps
    end
    add_reference :people, :country, foreign_key: true
  end
end
