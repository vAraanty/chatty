class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    @message = @conversation.messages.create!(message_params.merge(user: current_user))

    respond_to do |format|
      format.html { redirect_to conversation_path(@conversation) }
      format.turbo_stream # Enables real-time updates
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
