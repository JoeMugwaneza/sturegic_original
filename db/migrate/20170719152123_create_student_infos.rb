class CreateStudentInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :student_infos do |t|
      t.string :student_id
      t.integer :registrar_id
      t.integer :district_id
      t.integer :country_id
      t.integer :program_category_id
      t.string :education_level
      t.integer :course_id
      t.string :city

      t.timestamps
    end
  end
end
