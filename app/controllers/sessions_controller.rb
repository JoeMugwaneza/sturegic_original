class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id
<<<<<<< HEAD
      redirect_to root_url

=======

      if user.email_confirmed

        redirect_to root_url
      else

        flash[:error] = 'Please activate your account by following the instruction in the account confirmation email you received to proceed'
        
        render 'new'
      end
>>>>>>> ba4257cb0e9d2ae4510a1b2773e254f3dbbca74b
    else
      flash.now.alert = "Email or Password is invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out"
  end
end
