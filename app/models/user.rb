# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  email                :string
#  name                 :string
#  onboarding_completed :boolean          default(FALSE), not null
#  onboarding_step      :integer          default("profile"), not null
#  tag                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  provider_id          :string
#  stripe_customer_id   :string
#
class User < ApplicationRecord
  # == Extensions ===========================================================
  include Searchable

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
  def self.searchable_fields
    [ :email, :name, :tag ]
  end

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
