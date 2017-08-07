class Course < ApplicationRecord
  has_many :students, class_name: 'StudentInfo'
  belongs_to :program_category
end
