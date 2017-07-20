class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id


      if user.email_confirmed

        redirect_to root_url
      else

        flash[:error] = 'Please activate your account by following the instruction in the account confirmation email you received to proceed'
        
        redirect_to login_path
      end
    else
      flash.now.alert = "Email or Password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
  end
end
