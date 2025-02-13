class ConversationPolicy < ApplicationPolicy
  def show?
    record.present? && record.users.include?(user)
  end
end
