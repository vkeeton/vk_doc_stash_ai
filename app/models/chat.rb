class Chat < ApplicationRecord
  belongs_to :user

  has_many :messages, dependent: :destroy
  has_many :doc_chats
  has_many :docs, through: :doc_chats
  attr_accessor :doc_id
end
