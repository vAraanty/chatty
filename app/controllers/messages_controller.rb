class MessagesController < ApplicationController
  before_action :set_conversation

  def create
    Messages::Create.new
      .with_step_args(
        create_message: [ current_user: current_user, conversation: @conversation ]
      )
      .call(params[:message].to_unsafe_h) do |on|
        on.success do |message|
          @message = message

          respond_to do |format|
            format.html { redirect_to conversation_path(@conversation) }
            format.turbo_stream
          end
        end

        on.failure do |errors|
          flash[:alert] = errors.values.flatten.join(", ")

          redirect_to conversation_path(@conversation)
        end
      end
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
