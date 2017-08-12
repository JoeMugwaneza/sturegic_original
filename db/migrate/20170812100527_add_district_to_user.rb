class AddDistrictToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :district, :string
    add_column :student_infos, :program_time, :string
  end
end
