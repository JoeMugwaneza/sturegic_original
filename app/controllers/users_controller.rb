class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id

      UserMailer.registration_confirmation(@user).deliver

      flash[:success] = "Please confirm your email address to continue"

      redirect_to root_url
    else
      flash[:error] = "Ooops, something went wrong!"
      render 'new'
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :agent, :country_id, :reg_no, :sex, :martial_status, :tel, :password, :password_confirmation)
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])

    if user
      user.email_activate
      flash[:sucess] = "Welcome to Stregic system! you email has be confirmed, sign in to continue application"
      redirect_to new_student_info_path
    else
      flash[:error] = "Sorry, Student does not exit"
      redirect_to signup_path
    end
  end

end
