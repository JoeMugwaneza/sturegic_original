class User < ApplicationRecord
  has_secure_password
  
  has_many :studentInfos, foreign_key: :registrar_id

  belongs_to :country

  validates_uniqueness_of :email

  before_create :confirmation_taken
  before_create {generate_token(:auth_token)}


  def generate_token(column)
    begin 
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column]) 
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  private

  def confirmation_taken
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end

  def activate_email
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false) 
  end

end
