module Users
  class CreateStripeCustomerJob < ApplicationJob
    queue_as :default

    def perform(user_id, auth0_id)
      user = User.find(user_id)

      return if user.stripe_customer_id.present?

      stripe_customer = ::Stripe::Customer.create(
        email: user.email,
        name: user.name,
        metadata: {
          auth0_id: auth0_id
        }
      )

      user.update(stripe_customer_id: stripe_customer.id)
    end
  end
end
