class AddStatusToStudentInfo < ActiveRecord::Migration[5.1]
  def change
    add_column :student_infos, :status, :boolean
  end
end
