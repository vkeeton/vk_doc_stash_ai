class Doc < ApplicationRecord
  belongs_to :user

  has_many :doc_chats
  # validates :file_name, :file_type, presence: true
  # validates :character_count, length: { maximum: 4000 }

  has_one_attached :doc_asset
  has_one_attached :image
end
