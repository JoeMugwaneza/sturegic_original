class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  def log_in?
    !current_user.nil?
  end

  helper_method :current_user, :log_in?

  def authorize
    redirect_to login_url, alert: "Not Authorized" if current_user.nil?
  end
end
