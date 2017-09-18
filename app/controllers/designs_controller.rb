class DesignsController < ApplicationController
  before_action :authenticate_user
  def index
   @user = current_user
  end
  def paymentarchive
    if current_user.admin == true
      @students = User.where("admin = ? AND agent = ? AND enabled = ?", false, false, true)
    elsif current_user.agent == true && current_user.studentInfos.any?
      @students = []
      current_user.studentInfos.each do |studentInfo|
        @students.push(studentInfo.student)
      end
    else
      flash[:success] = "No archive payment to veiw"
      redirect_to "/"
    end 
  end
  def admindashboard1
    if current_user.admin == true
      @table_number = 0
      @approved_studentInfos = StudentInfo.where(status: true).order("student_1 ASC").paginate(:page => params[:page], :per_page => 25)
      @agents = User.where("agent_option = ? OR agent_option = ?", "Agent",  "Marketer")
      @admins = User.where("admin = ? AND enabled = ?", true, true)
      @studentInfos = StudentInfo.where(status: false)
    elsif current_user.agent == true
      if params[:district_id]
        @student_infos = current_user.studentInfos.where(district_id: params[:district_id])
        @int_student_infos = current_user.studentInfos.where(country_id: !Country.find_by(name:"Rwanda").id)

        render :admindashboard1
        
      elsif params[:program_id]
        @student_infos = current_user.studentInfos.where(program_category_id: params[:program_id])
        @int_student_infos = current_user.studentInfos.where(country_id: !Country.find_by(name:"Rwanda").id)

        render :admindashboard1
      elsif params[:course_id] 
        @student_infos = current_user.studentInfos.where(course_id: params[:course_id])
        @int_student_infos = current_user.studentInfos.where(country_id: !Country.find_by(name:"Rwanda").id)

        render :admindashboard1
      elsif params[:search]
        @student_infos = current_user.studentInfos.where(country_id: Country.find_by(name: "Rwanda").id)
        @int_student_infos = current_user.studentInfos.where(city: params[:search])

        render :admindashboard1
      else
        
        @student_infos = current_user.studentInfos.where(country_id: 1)
        @int_student_infos = current_user.studentInfos.where(country_id: !Country.find_by(name:"Rwanda").id)

        render :admindashboard1

      end
    else
      redirect_to student_path(current_user)
    end
  end

  def monthlypayments
    if current_user && current_user.admin
    @payment_recievers =  User.payment_eligible.where("admin = ? AND agent = ? AND enabled = ?", false, false, true).paginate(:page => params[:page], :per_page => 10)
    else
      flash[:warning]="Access denied"
      redirect_to "/"
    end
  end
end