class Course < ApplicationRecord
  
  has_many :studentInfos
  has_many :student
end
