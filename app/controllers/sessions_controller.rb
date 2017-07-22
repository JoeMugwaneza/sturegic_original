class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])

      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end

      if user.email_confirmed

        redirect_to root_url
      else
        flash[:info] = "Please activate your account by following the instruction in the account confirmation email you received to proceed"
        redirect_to login_path
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
