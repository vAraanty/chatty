class OnboardingController < ApplicationController
  before_action :require_onboarding
  before_action :set_step

  def show
    case @current_step
    when "profile"
      render "onboarding/steps/profile"
    when "subscription"
      render "onboarding/steps/subscription"
    end
  end

  def update
    case @current_step
    when "profile"
      handle_profile_step
    when "subscription"
      handle_subscription_step
    end
  end

  private

  def require_onboarding
    redirect_to root_path if current_user.onboarding_completed?
  end

  def set_step
    @current_step = current_user.onboarding_step
  end

  def handle_profile_step
    ::Users::Update.new
                  .with_step_args(update_user: [ user: current_user ], validate: [ user: current_user ])
                  .call(params[:user].to_unsafe_h) do |on|
      on.success do |result|
        current_user.update!(onboarding_step: :subscription)

        redirect_to onboarding_path
      end

      on.failure do |result|
        @errors = result
        render "onboarding/steps/profile", status: :unprocessable_entity
      end
    end
  end

  def handle_subscription_step
    current_user.update!(onboarding_completed: true, onboarding_step: :completed)
    redirect_to root_path
  end
end
