
class CreateCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :two_digit_code
      t.string :three_digit_code

      t.index :name, unique: true
      t.index :two_digit_code, unique: true
      t.index :three_digit_code, unique: true

      t.timestamps
    end
  end
end
