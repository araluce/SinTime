class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :messages, inverse_of: :admin, dependent: :destroy
  has_many :chat_clans, class_name: 'Chat::Clan', inverse_of: :admins, through: :messages

  has_many :chat_admins, class_name: 'Chat::Admin', inverse_of: :admin, dependent: :destroy
end
