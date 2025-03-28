module Auth0
  class Callback < ApplicationTransaction
    validate CallbackContract
    step :find_or_create_user
    step :store_session_data

    def find_or_create_user(auth_info:)
      user = User.find_or_create_by(provider_id: auth_info[:sub]) do |user|
        tag = auth_info[:nickname]

        while User.exists?(tag: tag)
          tag = "#{tag}-#{rand(1000)}"
        end

        user.tag = tag
        user.email = auth_info[:name]
        user.onboarding_step = :profile
        # Stripe customer creation moved to background job
      end

      # Enqueue background job to create or update Stripe customer
      Users::CreateStripeCustomerJob.perform_later(user.id, auth_info[:sub])

      Success(user: user, auth_info: auth_info)
    rescue => e
      Failure(e.message)
    end

    def store_session_data(user:, auth_info:, session:)
      session[:user_info] = auth_info
      session[:user_id] = user.id

      Success(user: user)
    end
  end
end
