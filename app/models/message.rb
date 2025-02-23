# == Schema Information
#
# Table name: messages
#
#  id              :integer          not null, primary key
#  content         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
# Foreign Keys
#
#  conversation_id  (conversation_id => conversations.id)
#  user_id          (user_id => users.id)
#
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
