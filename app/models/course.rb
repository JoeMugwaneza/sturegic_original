class Course < ApplicationRecord
  has_many :students, class_name: 'StudentInfo', :dependent => :restrict_with_error
  belongs_to :program_category
end
