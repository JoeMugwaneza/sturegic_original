class ProfilesController < ApplicationController

  def profile_one
    @user = User.friendly.find(params[:id])
    @student = StudentInfo.find_by(student_id: @user.id)
  end
  
  def profile_two
    @user = User.friendly.find(params[:id])
    @student = StudentInfo.find_by(student_id: @user.id)
  end

  def edit
     @user = User.friendly.find(params[:id])
  end
end
