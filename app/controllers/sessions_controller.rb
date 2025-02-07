class SessionsController < ApplicationController
  def new
    @user = session[:userinfo] || {}
  end
end
