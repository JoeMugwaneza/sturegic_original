class AddBankslipToStudentInfos < ActiveRecord::Migration[5.1]
  def change
    add_column :student_infos, :bankslip, :string
  end
end
