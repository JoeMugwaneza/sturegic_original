class UserMailer < ApplicationMailer
  default from: 'nexpals250@gmail.com'
  
  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registration Conformation")
  end
end
