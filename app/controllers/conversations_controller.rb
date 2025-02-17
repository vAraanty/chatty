class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations.where.associated(:messages)
                      .distinct.order("messages.created_at DESC")
  end

  def show
    @conversation = current_user.conversations.find_by(id: params[:id])

    authorize @conversation, policy_class: ConversationPolicy

    @messages = @conversation.messages.includes(:user).order("created_at ASC")
    @message  = Message.new
  end

  def create
    recipient = User.find_by(id: params[:recipient_id])

    authorize recipient, policy_class: ConversationPolicy

    Conversations::Create.call(current_user:, recipient:) do |on|
      on.success do |conversation|
        redirect_to conversation_path(conversation)
      end

      on.failure do |error|
        redirect_to user_path(recipient), alert: t(".failure")
      end
    end
  end
end
