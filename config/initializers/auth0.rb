Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.credentials.auth0[:client_id],
    Rails.application.credentials.auth0[:client_secret],
    Rails.application.credentials.auth0[:domain],
    callback_path: "/auth/auth0/callback",
    authorize_params: {
      scope: "openid profile"
    }
  )
end
