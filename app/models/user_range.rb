class UserRange < ApplicationRecord
  has_many :users,inverse_of: :range

  has_attached_file :icon, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ActionController::Base.helpers.image_path('thumb/missing.png')
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  validates :icon, :range_text, presence: true
  validates :min_score, numericality: {greater_than: 0, allow_nil: false, allow_blank: false}
end
