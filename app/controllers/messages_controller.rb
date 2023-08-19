class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @doc_contents = @chat.docs.first&.content
    @message = Message.new(message_params)
    authorize @message
    @message.chat = @chat
    @message.chat.user = current_user
    if @message.save
      ChatChannel.broadcast_to(
        @chat,
        render_to_string(partial: "message", locals: {message: @message})
      )

      combined_text = @message.contents.dup # Make a copy of message contents
      combined_text << @doc_contents if @doc_contents.present?

      if combined_text.present?
        @response = OpenaiService.new(combined_text).call
        @message.update(response: @response) # Save response from OpenAI in the message
        ChatChannel.broadcast_to(
          @chat,
          render_to_string(partial: "response", locals: {message: @response})
        )
      end

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
