class UsersController < ApplicationController
  before_action :authorize
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now

      flash[:success] = "Please confirm your #{@user.email} address to continue"

      redirect_to root_path
    else
      flash[:error] = "Ooops, something went wrong!"
      render 'new'
    end
  end


  def confirm_email
    @user = User.find_by(confirm_token: params[:token])
    @user.assign_attributes(email_confirmed: true, confirm_token: nil)
    if @user.save
      flash[:sucess] = "Welcome to Stregic system! you email has be confirmed, sign in to continue application"
      redirect_to "/student_infos/new?student_id=#{@user.id}"
    else
      flash[:error] = "Sorry, Student does not exit"
      redirect_to signup_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :agent, :country_id, :reg_no, :sex, :martial_status, :tel, :password, :password_confirmation)
  end


end
