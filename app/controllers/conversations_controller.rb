class ConversationsController < ApplicationController
  def index
    @conversations = current_user.conversations
  end

  def show
    @conversation = current_user.conversations.find_by(id: params[:id])

    authorize @conversation, policy_class: ConversationPolicy

    @messages = @conversation.messages
    @message  = Message.new
  end
end
