class Message < ApplicationRecord
  belongs_to :chatroom, inverse_of: :messages
  belongs_to :user, inverse_of: :messages, optional: true
  belongs_to :admin, inverse_of: :messages, optional: true

  validate :check_user
  validates :message, presence: true

  def to_s
    message
  end

  private

  def check_user
    errors.add(:user, 'Debe haber un emisor') if user.nil? && admin.nil?
  end
end
