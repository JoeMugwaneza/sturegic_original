class CreateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :districts do |t|
      t.string :name
      t.integer :province_id

      t.timestamps
    end
  end
end
