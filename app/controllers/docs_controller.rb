class DocsController < ApplicationController
  def index
    @docs = policy_scope(Doc)
    if current_user.chats.where(chat_name: "general").first
      @chat = current_user.chats.where(chat_name: "general").first
    else
      @chat = Chat.new(chat_name: "general")
      @chat.user = current_user
      @chat.save
    end
    authorize @chat
    @message = Message.new
    authorize @message
  end

  def create
    @doc = Doc.new(doc_params)
    @doc.user = current_user
    if @doc.save
      redirect_to docs_path
    else
      render :create
    end
    authorize @doc
  end

  def update
  end

  def destroy
  end

  private

  def doc_params
    params.require(:doc).permit(:file_name, :tag_name, :user_id, :character_count, :content, :file_type, :selected, :URL)
  end

  def chat_params
    params.require(:chat).permit(:user_id, :chat_name)
  end
end
