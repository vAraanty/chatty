class SubscriptionsController < ApplicationController
  def index
    if current_user.subscription && !current_user.subscription.stopped?
      session = Stripe::BillingPortal::Session.create(
        customer: current_user.stripe_customer_id,
        return_url: root_url
      )

      redirect_to session.url, allow_other_host: true
    end

    customer_session = Stripe::CustomerSession.create({
      customer: current_user.stripe_customer_id,
      components: { pricing_table: { enabled: true } }
    })

    @client_secret = customer_session.client_secret
  end
end
