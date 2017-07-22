class UserMailer < ApplicationMailer
  default from: 'nexpals250@gmail.com'
  
  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, :subject => "Registration Conformation")
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, :subject => "Password Reset")
  end
end
