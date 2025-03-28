module Auth0
  class CallbackContract < ApplicationContract
    config.messages.namespace = "auth0"

    params do
      required(:auth_info).hash do
        required(:sub).filled(:string)
        required(:nickname).filled(:string)
        required(:name).filled(:string)
      end
    end
  end
end
