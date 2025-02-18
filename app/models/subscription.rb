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
