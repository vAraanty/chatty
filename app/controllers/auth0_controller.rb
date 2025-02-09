# ./app/controllers/auth0_controller.rb
class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env["omniauth.auth"]["extra"]["raw_info"]

    user = User.find_or_create_by(provider_id: auth_info["sub"]) do |user|
      user.name  = auth_info["name"]
      user.email = auth_info["email"]
      # TODO: handle profile picture
    end

    session[:user_info] = auth_info
    session[:user_id] = user.id

    redirect_to root_path
  end

  def failure
    @error_msg = request.params["message"]
  end

  def logout
    reset_session

    redirect_to logout_url, allow_other_host: true
  end

  private

  def logout_url
    request_params = {
      returnTo: root_url,
      client_id: Rails.application.credentials.auth0[:client_id]
    }

    URI::HTTPS.build(host: Rails.application.credentials.auth0[:domain], path: "/v2/logout", query: request_params.to_query).to_s
  end
end
