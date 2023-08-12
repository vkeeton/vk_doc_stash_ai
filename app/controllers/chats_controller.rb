class ChatsController < ApplicationController
  def index
    @chats = policy_scope(Chat)
  end

  def new
    @chat = Chat.new
    authorize @chat
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.user = current_user
    if @chat.save
      redirect_to chat_path(@chat)
    else
      render new
    end
    authorize @chat
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    @response = Response.new
    authorize @chat
    authorize @message
    authorize @response
  end

  def update
  end

  private

  def chat_params
    params.require(:chat).permit(:user_id, :chat_name)
  end
end
