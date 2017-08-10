class UsersController < ApplicationController

    before_action :authenticate_user

    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
  # before_action :authorize
  def show
    user = User.friendly.find(params[:id])
    if current_user.admin == true || current_user == user
      @user = user
    else
      redirect_to student_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save 
      # UserMailer.registration_confirmation(@user).deliver_now
      if current_user.admin == true && @user.agent == true || @user.admin == true
        flash[:success] = "You have successfully added a new user"
        redirect_to "/"
      else
        flash[:success] = "You have successfully completed the first step"

        redirect_to "/student_infos/new?student_id=#{@user.id}"
      end
    elsif 
      flash[:error] = "Ooops, something went wrong!"
      render 'new'
    end
  end


  def confirm_email
    @user = User.find_by(confirm_token: params[:token])
    @user.assign_attributes(email_confirmed: true, confirm_token: nil)
    if @user.save
      flash[:sucess] = "Welcome to Stregic system! you email has be confirmed, sign in to continue application"

    if current_user
      redirect_to "/student_infos/new?student_id=#{@user.id}"

      if current_user
        redirect_to "/student_infos/new?student_id=#{@user.id}"
      else
        redirect_to "/login"
      end

    else
      redirect_to "/login"
    end
    else
      flash[:error] = "Sorry, Student does not exit"
      redirect_to signup_path
    end
    
  end


  def edit
    @user = User.friendly.find(params[:id])
  end

  def update
    @user = User.friendly.find(params[:id])
    
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(user_params)
      flash[:sucess] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :agent, :country_id, :sex, :martial_status, :tel, :password, :password_confirmation, :identification, :agent)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end

  #Confirm that the use who is going to edit the profit is correct
  def correct_user
    @user = User.friendly.find(params[:id])
    redirect_to root_path unless current_user?(@user) || current_user.admin?
  end

  #confirm that the user who want to update the info is signed in
  def logged_in_user
    unless log_in?
      flash[:danger] = "Please login in"
      redirect_to login_path
    end
  end

  def log_in?
    !current_user.nil?
  end

  def current_user?(user)
    user == current_user
  end
end
