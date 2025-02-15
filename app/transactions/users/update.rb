module Users
  class Update < ApplicationTransaction
    validate Users::UpdateContract
    step :update_user

    def update_user(params, user:)
      if user.update(params)
        Success(user)
      else
        Failure(user.errors.full_messages)
      end
    end
  end
end
