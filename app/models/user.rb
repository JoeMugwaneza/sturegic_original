class User < ApplicationRecord
  has_secure_password
  belongs_to :country
  validates_uniqueness_of :email
  has_many :studentInfos, foreign_key: :registrar_id
end
