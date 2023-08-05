class Doc < ApplicationRecord
  belongs_to :user

  has_many :doc_chats
  validates :file_name, :contents, :file_type, presence: true
  validates :character_count, length: { maximum: 4000 }
end
