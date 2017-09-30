class StudentInfosController < ApplicationController
   before_action :authenticate_user

  def index
    #approving the request
    if current_user.admin && params[:appr]
      @student_info = StudentInfo.find_by(id: params[:appr])
      @student_info.status = !@student_info.status
      @student_info.generate_registration
      if @student_info.save

        # StudentInfoMailer.student_info_approval_notification(@student_info).deliver_now
        flash[:success] = "#{@student_info.student.first_name} Registration Approved"
        redirect_to "/"
      else
        flash[:warning] = "Something is wrong, student registration approval failed"
        redirect_to :back
      end
    elsif current_user.admin && params[:decline]
      @student_info = StudentInfo.find_by(id: params[:decline])
      @user = @student_info.student
      if @student_info.destroy 
          @user.destroy
        # StudentInfoMailer.student_info_approval_notification(@student_info).deliver_now
        flash[:success] = "Student Registration Declined, and the data are removed from teh database"
        redirect_to "/"
      else
        flash[:warning] = "Something is wrong, student registration decline failed"
        redirect_to :back
      end
    elsif current_user.admin == true && params[:agent_rm]
      user = User.find_by(id: params[:agent_rm])
      user.enabled = false
      if user.save
        flash[:sucess] = "Agent removed"
        redirect_to "/"
      else
        flash[:warning] = "Removing agent #{user.first_name} failed"
        redirect_to "/"
      end
    end
  end

  def show
    find_student_infos
    redirect_to user_path(@student_infos.student)
  end

  def new
    @program_category = ProgramCategory.find_by(id: params[:program_id])
    @student = User.find_by(id: params[:student_id])
    @student_infos = StudentInfo.new
    @user = User.friendly.find_by(params[:id])
  end

  def create
    @user = current_user
    @student_infos = StudentInfo.new(student_infos_params) 
    if @student_infos.save 
     flash[:scuess] = "Student Application Successfully Submited" 
     redirect_to "/students/#{@student_infos.student.friendly_id}/profile-one"
    else
      @student = @student_infos.student
      @program_category = @student_infos.program_category
      render 'new'
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
    params.require(:student_info).permit(:education_level, :course_id, :program_category_id, :district_id, :registrar_id, :student_id, :country_id, :city, :reg_no, :bankslip, :program_time)
  end
end
