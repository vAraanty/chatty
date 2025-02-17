module Conversations
  class Create < ApplicationTransaction
    step :find_or_create

    def find_or_create(current_user:, recipient:)
      conversation = current_user.conversations.find do |conv|
        conv.users.count == 2 && conv.users.include?(recipient)
      end

      unless conversation
        conversation = Conversation.create
        conversation.user_conversations.create(user: current_user)
        conversation.user_conversations.create(user: recipient)
      end

      Success(conversation)
    end
  end
end
