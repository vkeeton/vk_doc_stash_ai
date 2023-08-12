class ResponsesController < ApplicationController
  def create
    # @message = Message.find(params[:message_id])
    # @response = OpenaiService.new(@chat.content).call
    # raise
    # if @response.present?
    #   @message.response = @response
    #   if @response.save
    #     redirect_to chat_path(@chat)
    #   else
    #     render 'chats/show', status: :unprocessable_entity
    #   end
    # # @response = Response.new(response_params)
    # @response.message = @message
    # @response.message.chat.user = current_user
    # # if @response.save
    # #   redirect_to docs_path
    # # else
    # #   render 'chats/show', status: :unprocessable_entity
    # # end
    # authorize @chat
    # authorize @message
    # authorize @response
  end

  private

  def message_params
    params.require(:response).permit(:contents)
  end
end
