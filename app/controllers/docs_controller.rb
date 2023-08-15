class DocsController < ApplicationController
  def index
    @doc = Doc.new
    @chat = current_user.chats.where(chat_name: "general").first_or_create do |chat|
      chat.user = current_user
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
    # lines 21 - 28 is hard-coded for the purpose of the demo on 8/12 we are still researching how to File.read an uploaded doc (which are commented out on lines 32+33)
    @doc.content = "Rails is a web application development framework written in the Ruby programming language. It is designed to make programming web applications easier by making assumptions about what every developer needs to get started. It allows you to write less code while accomplishing more than many other languages and frameworks. Experienced Rails developers also report that it makes web application development more fun.
    Rails is opinionated software. It makes the assumption that there is a 'best' way to do things, and it's designed to encourage that way - and in some cases to discourage alternatives. If you learn 'The Rails Way' you'll probably discover a tremendous increase in productivity. If you persist in bringing old habits from other languages to your Rails development, and trying to use patterns you learned elsewhere, you may have a less happy experience.
    The Rails philosophy includes two major guiding principles:
      •	Don't Repeat Yourself: DRY is a principle of software development which states that 'Every piece of knowledge must have a single, unambiguous, authoritative representation within a system'. By not writing the same information over and over again, our code is more maintainable, more extensible, and less buggy.
      •	Convention Over Configuration: Rails has opinions about the best way to do many things in a web application, and defaults to this set of conventions, rather than require that you specify minutiae through endless configuration files."
    @doc.file_name = "What is Ruby: A Guide"
    @doc.character_count = 2000
    @doc.file_type = ".txt"

    authorize @doc
    if @doc.save
      # the following 2 lines are in progress to be able to actually extract the content from the document that is uploaded
      # file = "app/assets/Test2.rtf"
      # p File.read(file)
      redirect_to docs_path
    else
      render :create
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
