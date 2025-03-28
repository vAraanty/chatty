# ./app/controllers/auth0_controller.rb
class Auth0Controller < ApplicationController
  def callback
    auth_info = request.env["omniauth.auth"]["extra"]["raw_info"]

    Auth0::Callback.call(auth_info: auth_info, session: session) do |on|
      on.success do |result|
        user = result[:user]
        if !user.onboarding_completed?
          redirect_to onboarding_path
        else
          redirect_to root_path
        end
      end

      on.failure do |error|
        @error_msg = error
        render :failure
      end
    end
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
