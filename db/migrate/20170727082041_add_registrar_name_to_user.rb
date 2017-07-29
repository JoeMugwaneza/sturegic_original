class AddRegistrarNameToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :registrar_name, :string
  end
end
