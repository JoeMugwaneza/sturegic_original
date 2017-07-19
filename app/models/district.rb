class District < ApplicationRecord
  has_many :students
  belongs_to :province
end
