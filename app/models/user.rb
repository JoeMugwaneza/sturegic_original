class User < ApplicationRecord
  has_secure_password
  
  has_many :studentInfos, foreign_key: :registrar_id

  belongs_to :country

  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, :if => :password_digest_changed?
  # validates :password, :presence => true,
  #                      :confirmation => true,
  #                      :length => { :within => 6..40 },
  #                      :unless => :already_has_password?


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
    #Confirm that the use who is going to edit the profit is corrent
  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless current_user?(@user) || current_user.admin?
  end

  #confirm that the user who want to update the info is signed in
  def logged_in_user
    unless log_in?
      flash[:danger] = "Please login in"
      redirect_to login_path
    end
  end

  def log_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end

  # def already_has_password?
  #     !self.password_digest.blank?
  # end
end
