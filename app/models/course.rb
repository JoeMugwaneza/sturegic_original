class Course < ApplicationRecord
  has_many :student_infos
  has_many :student
  belongs_to :program_category
end
