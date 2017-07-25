class ProfilesController < ApplicationController
  
  def profile
    @user = User.find_by(id: params[:id])
  end
end
