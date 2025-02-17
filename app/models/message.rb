class Message < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Relationships ========================================================
  belongs_to :conversation
  belongs_to :user

  has_many_attached :files

  # == Validations ==========================================================
  validates :content, presence: true

  # == Scopes ===============================================================

  # == Callbacks ============================================================
  normalizes :content, with: ->(content) { content.strip }

  after_create_commit do
    broadcast_append_to "conversation_#{conversation.id}", target: "messages"
  end

  # == Class Methods ========================================================

  # == Instance Methods ====================================================
end
