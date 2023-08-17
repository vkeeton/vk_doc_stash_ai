class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @doc_contents = @chat.docs.first.content
    @message = Message.new(message_params)
    authorize @message
    @message.chat = @chat
    @message.chat.user = current_user
    if @message.save
      ChatChannel.broadcast_to(
        @chat,
        render_to_string(partial: "message", locals: {message: @message})
      )
      @response = OpenaiService.new(@message.contents + @doc_contents).call
      @message.update(response: @response) #save response from open ai in message
      ChatChannel.broadcast_to(
        @chat,
        render_to_string(partial: "response", locals: {message: @response})
      )
      head :ok
    else
      render 'chats/show', status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:contents)
  end
end
