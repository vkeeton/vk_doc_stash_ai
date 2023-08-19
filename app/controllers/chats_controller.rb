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
      if params[:chat][:doc_id]
        chat_doc = DocChat.new(doc_id: params[:chat][:doc_id].to_i)
        chat_doc.chat = @chat
        chat_doc.save
      end
      redirect_to docs_path(chat_id: @chat.id)
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
