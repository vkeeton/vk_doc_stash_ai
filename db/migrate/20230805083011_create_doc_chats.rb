class CreateDocChats < ActiveRecord::Migration[7.0]
  def change
    create_table :doc_chats do |t|
      t.references :doc, null: false, foreign_key: true
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
