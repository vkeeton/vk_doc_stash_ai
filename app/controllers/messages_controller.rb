class MessagesController < ApplicationController
  def create
    @chat = Chat.find(params[:chat_id])
    @doc_contents = @chat.docs.first&.content
    @message = Message.new(message_params)
    @message.from_ai = false
    authorize @message
    @message.chat = @chat
    @message.chat.user = current_user
    if @message.save
      ChatChannel.broadcast_to(
        @chat,
        render_to_string(partial: "message", locals: {message: @message})
      )
      instructions = "Instructions: Respond to the following query in 40 words or less using information in the Contents. Try to make to the response as concise as possible and keep the word count as low as possible."
      combined_text = instructions + "\n\n" + "Query: " + @message.contents.dup  # Prepend instructions to message contents
      combined_text << "\n\n" + "Contents: " + @doc_contents if @doc_contents.present?

      if combined_text.present?
        @response = OpenaiService.new(combined_text).call
        @message.update(response: @response) # Save response from OpenAI in the message

        # Create a new AI message and save it in the database
        ai_message = Message.new(contents: @response, chat: @chat) # You can change the user if you have a specific AI user
        ai_message.from_ai = true
        ai_message.save

        ChatChannel.broadcast_to(
          @chat,
          render_to_string(partial: "response", locals: {message: ai_message})
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
