class ProfilesController < ApplicationController
  before_action :authenticate_user
  def profile_one
    @user = User.friendly.find(params[:id])
    @student = StudentInfo.find_by(student_id: @user.id)
  end
  
  def profile_two
    user = User.friendly.find(params[:id])
    if user.admin != true && user.agent != true
      @user = user
      @studentInfo = StudentInfo.find_by(student_id: @user.id)
    else
      flash[:warning] = "You don't have registration profile"
      redirect_to "/"
    end
  end

  def user_edit
     @user = User.friendly.find(params[:id])
  end

  def student_edit
    @user = User.friendly.find(params[:id])
    @studentInfo = StudentInfo.find_by(student_id: @user.id)
    @student = @studentInfo.student
  end

  def user_update
    @user = User.friendly.find(params[:id])
    params[:user].delete(:password) if params[:user][:password].blank?

    if @user.update_attributes(user_params) 
      flash[:sucess] = "Profile updated"
      redirect_to @user
    else
      render 'user_edit'
    end
  end

  def student_update
    @user = User.friendly.find(params[:id])
    @student = StudentInfo.find_by(student_id: @user.id)

    if @studentInfo.update_attributes(student_infos_params)
      redirect_to @user, alert: 'Profile updated'
    else 
      render 'student_edit'
    end
  end

  private


  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :agent, :country_id, :sex, :martial_status, :tel, :password, :password_confirmation, :identification, :agent)
  end

  def student_infos_params
    params.require(:student_info).permit(:education_level, :course_id, :program_category_id, :district_id, :registrar_id, :student_id, :country_id, :city, :reg_no, :bankslip)
  end
end
