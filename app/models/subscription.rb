# == Schema Information
#
# Table name: subscriptions
#
#  id                     :integer          not null, primary key
#  current_period_end     :datetime
#  current_period_start   :datetime
#  plan_name              :string
#  status                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_subscription_id :string
#  user_id                :integer          not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Subscription < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================

  # == Attributes ===========================================================
  enum :status, {
    trialing: 0,
    active: 1,
    past_due: 2,
    canceled: 3,
    incomplete: 4,
    incomplete_expired: 5,
    unpaid: 6
  }

  # == Relationships ========================================================
  belongs_to :user

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods ====================================================
  def stopped?
    status.blank? || status.in?(%i[past_due canceled incomplete incomplete_expired unpaid])
  end
end
