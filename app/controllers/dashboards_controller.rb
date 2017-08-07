class DashboardsController < ApplicationController
  def index
    @user = User.friendly.find_by(params[:id])
  end
end
