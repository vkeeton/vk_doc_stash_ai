class Message < ApplicationRecord
  belongs_to :chat

  has_many :responses
end
