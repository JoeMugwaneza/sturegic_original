class User < ApplicationRecord
  has_secure_password
  
  validates_uniqueness_of :email
  has_many :studentInfos, foreign_key: :registrar_id
end
