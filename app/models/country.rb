class Country < ApplicationRecord
  has_many :users, :dependent => :restrict_with_error
  has_many :student_infos, :dependent => :restrict_with_error
  has_many :provinces, :dependent => :restrict_with_error
end
