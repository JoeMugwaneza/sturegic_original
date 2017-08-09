class ProgramCategory < ApplicationRecord
   has_many :students, class_name: 'StudentInfo', :dependent => :restrict_with_error
   has_many :courses, :dependent => :restrict_with_error
end
