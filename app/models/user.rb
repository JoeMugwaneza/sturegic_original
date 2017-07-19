class User < ApplicationRecord
  has_secure_password
  belongs_to :country
  has_many :studentInfos, foreign_key: :registrar_id
end
