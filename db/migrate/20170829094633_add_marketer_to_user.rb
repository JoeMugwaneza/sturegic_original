class AddMarketerToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :agent_option, :string
  end
end
