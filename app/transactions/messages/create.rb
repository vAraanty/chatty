module Messages
  class Create < ApplicationTransaction
    validate CreateContract
    step :create_message

    def create_message(validated_params, current_user:, conversation:)
      message = conversation.messages.create(validated_params.merge(user: current_user))

      if message.persisted?
        Success(message)
      else
        Failure(message.errors.to_h)
      end
    end
  end
end
