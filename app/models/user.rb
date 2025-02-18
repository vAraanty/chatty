class User < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================

  # == Attributes ===========================================================
  enum :onboarding_step, {
    profile: 0,
    subscription: 1,
    completed: 2
  }

  # == Relationships ========================================================
  with_options dependent: :destroy do
    has_many :user_conversations
    has_many :messages
    has_one :subscription
  end

  has_many :conversations, through: :user_conversations

  has_one_attached :avatar

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods ====================================================
  def subscribed?
    subscription&.active?
  end

  def trial?
    subscription&.trial?
  end

  def subscription_status
    subscription&.status
  end
end
