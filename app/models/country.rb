class Country < ApplicationRecord
  has_many :users
  has_many :student_infos
  has_many :provinces
end
