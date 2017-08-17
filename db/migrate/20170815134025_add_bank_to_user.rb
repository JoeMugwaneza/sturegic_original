class AddBankToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :bank, :string
    add_column :users, :bank_account, :string
  end
end
