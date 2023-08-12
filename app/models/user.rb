class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # user has many docs; if we want to destroy a doc, we don't need
  # to destroy a user
  has_many :docs, dependent: :destroy
  has_many :chats
  has_one_attached :photo
end
