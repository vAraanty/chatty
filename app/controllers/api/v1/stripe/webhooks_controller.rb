module Api
  module V1
    module Stripe
      class WebhooksController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :authenticate_user!

        def create
          payload = request.body.read
          sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
          endpoint_secret = Rails.application.credentials.stripe[:webhook_secret]

          begin
            event = ::Stripe::Webhook.construct_event(
              payload, sig_header, endpoint_secret
            )
          rescue JSON::ParserError => e
            Rails.logger.error("JSON Parse Error: #{e.message}")
            return head :bad_request
          rescue ::Stripe::SignatureVerificationError => e
            Rails.logger.error("Signature Verification Error: #{e.message}")
            return head :bad_request
          end

          # Handle the event
          case event.type
          when "customer.subscription.created"
            handle_subscription_created(event)
          when "customer.subscription.updated"
            handle_subscription_updated(event)
          when "customer.subscription.deleted"
            handle_subscription_deleted(event)
          when "customer.subscription.trial_will_end"
            handle_subscription_trial_ending(event)
          else
            Rails.logger.info("Unhandled event type: #{event.type}")
          end

          head :ok
        end

        private

        def handle_subscription_created(event)
          stripe_subscription = event.data.object

          user = User.find_by!(stripe_customer_id: stripe_subscription.customer)

          user.create_subscription!(
            stripe_subscription_id: stripe_subscription.id,
            status: stripe_subscription.status,
            current_period_start: Time.at(stripe_subscription.current_period_start),
            current_period_end: Time.at(stripe_subscription.current_period_end)
          )

          Rails.logger.info("Subscription created: #{stripe_subscription.id}")
        end

        def handle_subscription_updated(event)
          stripe_subscription = event.data.object

          subscription = Subscription.find_by!(stripe_subscription_id: stripe_subscription.id)

          subscription.update!(
            status: stripe_subscription.status,
            current_period_start: Time.at(stripe_subscription.current_period_start),
            current_period_end: Time.at(stripe_subscription.current_period_end)
          )

          Rails.logger.info("Subscription updated: #{stripe_subscription.id}")
        end

        def handle_subscription_deleted(event)
          stripe_subscription = event.data.object

          subscription = Subscription.find_by!(stripe_subscription_id: stripe_subscription.id)
          subscription.update!(status: "canceled")

          Rails.logger.info("Subscription deleted: #{stripe_subscription.id}")
        end

        def handle_subscription_trial_ending(event)
          stripe_subscription = event.data.object

          subscription = Subscription.find_by!(stripe_subscription_id: stripe_subscription.id)
          user = subscription.user

          # TODO: Send email notification to user about trial ending
          # UserMailer.trial_ending(user).deliver_later

          Rails.logger.info("Subscription trial ending: #{stripe_subscription.id}")
        end
      end
    end
  end
end
