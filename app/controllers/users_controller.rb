class UsersController < ApplicationController
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find(params[:id])
    end
  end
end
