class ProgramCategory < ApplicationRecord
   has_many :students, class_name: 'StudentInfo'
   has_many :courses
end
