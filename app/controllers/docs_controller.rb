require "open-uri"
require "ruby-rtf"

class DocsController < ApplicationController
  def index
    @doc = Doc.new
    if params[:chat_id]
      @chat = Chat.find(params[:chat_id])
    else
      @chat = current_user.chats.where(chat_name: "general").first_or_create do |chat|
        chat.user = current_user
      end
    end
    authorize @chat
    @message = Message.new
    authorize @message

    if params[:query].present?
      @docs = policy_scope(Doc).where("file_name ILIKE ?", "%#{params[:query]}%")
    else
      @docs = policy_scope(Doc)
    end
  end

  def show
    @doc = Doc.find(params[:id])
    authorize @doc
  end

  # def new
  #   @doc = Doc.new
  #   authorize @doc
  # end

  def create
    @doc = Doc.new(doc_params)
    @doc.user = current_user
    authorize @doc

    if @doc.save
      url = @doc.doc_asset.url
      @file = URI.open(url).read
      # if conditional if the user uploads txt or rtf
      if url.ends_with?("rtf")
        parser = RubyRTF::Parser.new
        parsed_text = parser.parse(@file).sections.map do |val|
          val[:text]
        end.join(' ')
        @doc.file_name = "#{parsed_text[0..15]}..."
        @doc.file_type = "rtf"
        @doc.content = parsed_text
        @doc.character_count = parsed_text.size
        @doc.save
      elsif url.ends_with?("txt")
        @doc.file_name = "#{@file[0..15]}..."
        @doc.file_type = "txt"
        @doc.content = @file
        @doc.character_count = @file.size
        @doc.save
      end
      redirect_to docs_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  def update
  end

  def destroy
  end

  private

  def doc_params
    params.require(:doc).permit(:doc_asset)
  end

  def chat_params
    params.require(:chat).permit(:user_id, :chat_name)
  end
end
