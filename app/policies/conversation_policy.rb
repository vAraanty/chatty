class ConversationPolicy < ApplicationPolicy
  def show?
    record.present? && record.users.include?(user)
  end

  def create?
    record.present? && record != user
  end
end
