class ChatsController < ApplicationController
  def index
    @chats = policy_scope(Chat)
  end

  def new
    @chat = Chat.new
    current_doc_id = params[:doc]
    @docs = Doc.where.not(id: current_doc_id)
    authorize @chat
  end

  def create
    @chat = Chat.new(chat_params)
    @chat.user = current_user
    authorize @chat
    if @chat.save
      DocChat.create(doc_id: params[:chat][:doc_id], chat_id: @chat.id)
      selected_doc_ids = params[:chat][:doc_ids] || []
      selected_doc_ids.each do |doc_id|
        DocChat.find_or_create_by(doc_id: doc_id, chat_id: @chat.id)
      end

      redirect_to docs_path(chat_id: @chat.id)
    else
      render new
    end
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
    params.require(:chat).permit(:user_id, :chat_name, doc_ids:[])
  end
end
