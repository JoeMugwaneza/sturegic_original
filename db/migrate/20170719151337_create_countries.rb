class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :icon
      t.string :abbreviation

      t.timestamps
    end
  end
end
