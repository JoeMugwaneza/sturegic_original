class Province < ApplicationRecord
  belongs_to :country
  has_many :districts, :dependent => :restrict_with_error
end
