class AddRegNoToStudentInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :student_infos, :reg_no, :string
    remove_column :users, :reg_no, :string
  end
end
