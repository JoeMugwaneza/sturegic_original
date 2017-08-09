class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email]) || StudentInfo.find_by(reg_no: params[:reg_no]).student
    if user && user.authenticate(params[:password])

      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end

      if user.admin == true || user.agent == true

        redirect_to root_path, notice: "Signed in"
      else
        redirect_to student_path(user), notice: 'Signed in'
      end

    else
      flash[:warning] = "Email or Password is invalid"
      redirect_to login_path
    end
  end


  def destroy
    cookies.delete(:auth_token)
    redirect_to login_path, notice: "Logged out"
  end
end
