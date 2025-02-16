module Users
  class UpdateContract < ApplicationContract
    config.messages.namespace = "users"

    TAG_REGEX = /\A[a-zA-Z0-9_-]+\z/

    option :user

    params do
      required(:name).filled(:string)
      required(:tag).filled(:string)
      optional(:avatar)
    end

    rule(:tag) do
      key.failure(:invalid_format) unless value =~ TAG_REGEX

      if User.where.not(id: user.id).where("LOWER(tag) = ?", value.downcase).exists?
        key.failure(:already_taken)
      end
    end
  end
end
