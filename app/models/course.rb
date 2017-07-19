class Course < ApplicationRecord
  has_many :studentInfos
  has_many :student
  belongs_to :program_category
end
