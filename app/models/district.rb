class District < ApplicationRecord
  has_many :student_infos, :dependent => :restrict_with_error
  belongs_to :province
end
