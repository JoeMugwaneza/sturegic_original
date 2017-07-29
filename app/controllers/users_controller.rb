class UsersController < ApplicationController
    before_action :logged_in_user, only: [:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
  # before_action :authorize
  def show
    find_user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.registration_confirmation(@user).deliver_now

      flash[:success] = "Please confirm your email address: #{@user.email} to continue"

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
      if current_user
        redirect_to "/student_infos/new?student_id=#{@user.id}"
      else
        redirect_to "/login"
      end
    else
      flash[:error] = "Sorry, Student does not exit"
      redirect_to signup_path
    end
    
  end


  def edit
     find_user
  end

  def update
    find_user
    params[:user].delete(:password) if params[:user][:password].blank?
    if @user.update_attributes(user_params)
      flash[:sucess] = "Profile updated"
      redirect_to root_path
    else
      render 'edit'
    end

  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :admin, :agent, :country_id, :sex, :martial_status, :tel, :password, :password_confirmation, :identification)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  #Confirm that the use who is going to edit the profit is corrent
  def correct_user
    @user = User.find_by(id: params[:id])
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
