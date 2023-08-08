class DocsController < ApplicationController
  def index
    @docs = policy_scope(Doc)
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
end
