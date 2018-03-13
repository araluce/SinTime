class District < ApplicationRecord
  has_attached_file :logo, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ActionController::Base.helpers.image_path('thumb/missing.png')
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

  has_many :users, inverse_of: :district

  has_one :chat_room, inverse_of: :district, dependent: :destroy

  validates :name, presence: true

  def to_s
    name
  end
end
