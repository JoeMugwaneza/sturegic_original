class StudentInfosController < ApplicationController
  before_action :authorize
  def index
    if current_user.admin
      @pending_student_infos = StudentInfo.where(status: false)
      @approved_student_infos = StudentInfo.where(status: true)
      if params[:appr]
        @student_info = StudentInfo.find_by(id: params[:appr])
        @student_info.status = !@student_info.status
        if @student_info.save
          StudentInfoMailer.student_info_approval_notification(@student_info).deliver_now
          flash[:success] = "Student Registration Approved"
          redirect_to "/student_infos"
        else
          flash[:warning] = "Something is wrong, student registration approval failed"
          redirect_to "/student_info"
        end
      end
    else
      @pending_student_infos = current_user.students.where(status: false)
      @approved_student_infos = current_user.students.where(status: true)
    end
  end

  def show
    
  end

  def new
    @program_category = ProgramCategory.find_by(id: params[:program_id])
    @student = User.find_by(id: params[:student_id])
    @student_infos = StudentInfo.new
  end

  def create
    @student_infos = StudentInfo.new(student_infos_params)
    if @student_infos.save
      StudentInfoMailer.student_info_approval(@student_infos).deliver_now
     flash[:scuess] = "Student Application Successfully Submited" 
     redirect_to "/"
    else
      render :new
    end
  end

  def edit
    find_student_infos
    @student = @student_infos.student
  end

  def update
    find_student_infos
    if ProgramCategory.find_by(id: student_infos_params["program_category_id"]).courses.include?(Course.find_by(id: student_infos_params["course_id"]))
      @student_infos.update(student_infos_params)
      flash[:sucess] = "#{@student_infos.student.username} registration Info Updated"
      redirect_to "/"
    else
      redirect_to "/student_infos/#{find_student_infos.id}/edit"
    end
  end
  private
  def find_student_infos
    @student_infos = StudentInfo.find_by(id: params[:id])
  end
  def student_infos_params
    params.require(:student_info).permit(:education_level, :course_id, :program_category_id, :district_id, :registrar_id, :student_id, :country_id, :city)
  end
end
