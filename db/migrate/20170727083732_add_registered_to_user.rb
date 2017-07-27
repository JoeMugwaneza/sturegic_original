class AddRegisteredToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :application_submission, :boolean, default: false
  end
end
