class User < ApplicationRecord
  has_secure_password
  
  has_many :studentInfos, foreign_key: :registrar_id
end
