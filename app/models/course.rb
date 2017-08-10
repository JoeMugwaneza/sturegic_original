class Course < ApplicationRecord
  has_many :students, class_name: 'StudentInfo', :dependent => :restrict_with_error
  belongs_to :program_category
  rails_admin do
    edit do
      exclude_fields :id, :students
    end
    list do
      exclude_fields :id, :students
    end
  end
end
