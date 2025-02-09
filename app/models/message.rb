class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create_commit do
    broadcast_append_to "conversation_#{conversation.id}", target: "messages"
  end
end
