class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.boolean :admin, default: false
      t.boolean :agent, default: false
      t.integer :country_id
      t.string :reg_no
      t.string :sex
      t.string :martial_status
      t.string :tel
      t.string :password_digest

      t.timestamps
    end
  end
end
