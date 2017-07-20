class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])

      session[:user_id] = user.id

      # if user.email_confirmed

      #   redirect_to root_url
      # else

      #   flash[:error] = 'Please activate your account by following the instruction in the account confirmation email you received to proceed'
        
      #   render 'new'
      # end
      redirect_to root_path

    else
      flash.now.alert = "Email or Password is invalid"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end
end
