class AddUserReferencesToChats < ActiveRecord::Migration[7.0]
  def change
    add_reference :chats, :user, index: true
  end
end
