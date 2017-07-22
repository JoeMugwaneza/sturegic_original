class StudentInfoMailer < ApplicationMailer
  default to: Proc.new {User.where(admin: true).pluck(:email)}
  default from: 'nexpals250@gmail.com'
   
  def student_info_approval(student_info)
   @student_info = student_info
   # @url = 
   mail(subject: "New Student Registration is Waiting for your Approval")
  end

  def student_info_approval_notification(student_info)
    @student_info = student_info
    emails = ["#{@student_info.student.email}", "#{@student_info.registrar.email}"]
    mail(to: emails, subject: 'New Registration Approval on Sturegic')
  
  end
end
