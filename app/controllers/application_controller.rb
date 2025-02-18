class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!
  before_action :check_onboarding

  def authenticate_user!
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def current_user
    @current_user
  end

  def check_onboarding
    if current_user && !current_user.onboarding_completed? && !self.is_a?(OnboardingController)
      redirect_to onboarding_path
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."

    redirect_to root_path
  end
end
