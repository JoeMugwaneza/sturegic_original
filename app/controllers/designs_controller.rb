class DesignsController < ApplicationController
  def index
   @user = current_user
  end
  def admindashboard1
    @table_number = 0
    @students = User.where("admin = ? AND agent = ?", false, false)
    @agents = User.where(agent: true)
    @admins = User.where(admin: true)
  end
end
