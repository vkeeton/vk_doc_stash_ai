class ChatsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    authorize @chat
    authorize @message
  end

  def update
  end
end
