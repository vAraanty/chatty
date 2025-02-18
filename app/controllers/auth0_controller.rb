# ./app/controllers/auth0_controller.rb
class Auth0Controller < ApplicationController
  def callback
    # TODO: refactor to use transaction
    auth_info = request.env["omniauth.auth"]["extra"]["raw_info"]

    user = User.find_or_create_by(provider_id: auth_info["sub"]) do |user|
      tag = auth_info["nickname"]

      while User.exists?(tag: tag)
        tag = "#{tag}-#{rand(1000)}"
      end

      user.tag = tag
      user.email = auth_info["name"]
      user.onboarding_step = :profile

      # Create Stripe customer
      # TODO: move to background job
      stripe_customer = ::Stripe::Customer.create(
        email: user.email,
        name: user.name,
        metadata: {
          auth0_id: auth_info["sub"]
        }
      )

      user.stripe_customer_id = stripe_customer.id
      # TODO: handle profile picture
    end

    session[:user_info] = auth_info
    session[:user_id] = user.id

    if !user.onboarding_completed?
      redirect_to onboarding_path
    else
      redirect_to root_path
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
