class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.chat.user = current_user
    if @message.save
      redirect_to docs_path
    else
      render 'chats/show', status: :unprocessable_entity
    end
    authorize @chat
    authorize @message
  end

  private

  def message_params
    params.require(:message).permit(:contents)
  end
end
