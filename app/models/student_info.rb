class StudentInfo < ApplicationRecord
  belongs_to :student, class_name: 'User'
  belongs_to :registrar, class_name: 'User'
  belongs_to :district
  belongs_to :program_category
  belongs_to :country
  belongs_to :course
end
