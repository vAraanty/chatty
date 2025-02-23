# == Schema Information
#
# Table name: conversations
#
#  id                :integer          not null, primary key
#  conversation_type :integer          default("direct"), not null
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Conversation < ApplicationRecord
  # == Extensions ===========================================================

  # == Constants ============================================================

  # == Attributes ===========================================================
  enum :conversation_type, { direct: 0, group: 1 }, suffix: :conversation

  # == Relationships ========================================================
  with_options dependent: :destroy do
    has_many :messages
    has_many :user_conversations
  end

  has_many :users, through: :user_conversations

  # == Validations ==========================================================

  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # == Class Methods ========================================================

  # == Instance Methods ====================================================
end
