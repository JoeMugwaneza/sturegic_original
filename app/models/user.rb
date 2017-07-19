class User < ApplicationRecord
  has_secure_password
  
  has_many :studentInfos, foreign_key: :registrar_id

  belongs_to :country

  validates_uniqueness_of :email
  validates :password, length: { minimum: 6 }

  before_create :confirmation_taken
  
  private

  def confirmation_taken
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
    
  end
end
