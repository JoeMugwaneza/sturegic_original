class DashboardsController < ApplicationController
  before_action :authenticate_user
  def index
    @user = User.friendly.find_by(params[:id])
  end
end
