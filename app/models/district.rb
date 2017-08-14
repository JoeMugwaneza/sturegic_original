class District < ApplicationRecord
  has_many :student_infos, :dependent => :restrict_with_error
  belongs_to :province

  rails_admin do
    edit do
      exclude_fields :id, :students, :student_infos
    end
    list do
      exclude_fields :id, :students, :student_infos
    end
  end
end
