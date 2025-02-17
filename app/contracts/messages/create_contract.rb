module Messages
  class CreateContract < ApplicationContract
    config.messages.namespace = "messages"

    MAX_MESSAGE_LENGTH = 1000
    MAX_FILES = 10
    MAX_FILE_SIZE = 10.megabytes

    params do
      required(:content).filled(:string)
      optional(:files).maybe(:array)
    end

    rule(:content).validate do
      if value.present? && value.length > MAX_MESSAGE_LENGTH
        key.failure(:message_too_long)
      end
    end

    rule(:files).validate do
      if value.present? && value.any? { |it| it.size > MAX_FILE_SIZE }
        key.failure(:file_too_large)
      elsif value.present? && value.size > MAX_FILES
        key.failure(:file_limit_exceeded)
      end
    end
  end
end
