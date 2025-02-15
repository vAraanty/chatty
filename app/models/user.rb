class User < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================
  with_options dependent: :destroy do
    has_many :user_conversations
    has_many :messages
  end

  has_many :conversations, through: :user_conversations

  has_many_attached :avatars

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods ====================================================
end
