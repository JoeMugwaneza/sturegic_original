class User < ApplicationRecord
  has_secure_password
  extend FriendlyId

  friendly_id :username, use: :slugged


  def should_generate_new_friendly_id?
    new_record?
  end
  
  has_many :studentInfos, foreign_key: :registrar_id
  has_one :studentInfo, foreign_key: :student_id

  belongs_to :country

  validates_uniqueness_of :email
  validates_presence_of :username, :message =>'leaving no space between letters is recommended'
  validates_presence_of :email, :message => 'Use the valid email; we will use it to send you monthly summary'

  validates_presence_of :sex, :message => 'enter either male or female'
  validates_presence_of :martial_status, :message => 'Let us know whether you are single, married, ....'
  validates_presence_of :tel, :message => 'Enter the phone number we can use to reach you '
  validates_presence_of :identification, :message => "Enter your national ID number, or password"
  validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :create
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? } 


  before_create :confirmation_taken
  before_create {generate_token(:auth_token)}


  #please during deployment remember to change the program_category_id accordingly becuase they may mess up with your database
  def techgroups
    students = []
    self.studentInfos.where(program_category_id: 1).each do |studentInfo|
      students.push(studentInfo.student)
    end
    groups = students.each_slice(1).to_a

    return groups
  end

  def trafficgroups
    students = []
    self.studentInfos.where(program_category_id: 2).each do |studentInfo|
      students.push(studentInfo.student)
    end
    groups = students.each_slice(2).to_a

    return groups
  end


  def englishgroups
    students = []
    self.studentInfos.where(program_category_id: 3).each do |studentInfo|
      students.push(studentInfo.student)
    end
    groups = students.each_slice(5).to_a

    return groups
  end

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

  include UsersHelper
  
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

end
