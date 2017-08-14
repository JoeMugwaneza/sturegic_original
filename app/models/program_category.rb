class ProgramCategory < ApplicationRecord
   has_many :students, class_name: 'StudentInfo', :dependent => :restrict_with_error
   has_many :courses, :dependent => :restrict_with_error

  rails_admin do
    edit do
      exclude_fields :id, :students
    end
    list do
      exclude_fields :id, :students
    end
  end
end
