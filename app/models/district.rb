class District < ApplicationRecord
  has_many :student_infos
  belongs_to :province
end
