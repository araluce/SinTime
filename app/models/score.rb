class Score < ApplicationRecord
  include TimeHelper

  has_attached_file :icon, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ActionController::Base.helpers.image_path('thumb/missing.png')
  validates_attachment_content_type :icon, content_type: /\Aimage\/.*\z/

  has_many :benefit_scores, inverse_of: :score, dependent: :destroy
  has_many :exercises, inverse_of: :scores, through: :benefit_scores

  before_save :set_time_benefit

  validates :icon,
            :title,
            presence: true

  before_save :set_time_benefit

  attr_accessor :days_benefit,
                :hours_benefit,
                :minutes_benefit,
                :seconds_benefit

  validates :days_benefit,
            :hours_benefit,
            :minutes_benefit,
            :seconds_benefit,
            numericality: {allow_nil: false, allow_blank: false}

  validates :time_benefit, numericality: {greater_than_or_equal_to: 0, only_integer: true}
  validate :check_time

  def to_s
    title
  end

  private

  def set_time_benefit
    self.time_benefit = days_to_seconds(days_benefit.to_f) + hours_to_seconds(hours_benefit.to_f) + minutes_to_seconds(minutes_benefit.to_f) + seconds_benefit.to_f
  end

  def check_time
    unless set_time_benefit > 0
      errors.add(:days_benefit, 'El tiempo de beneficio debe ser mayor que 0')
      errors.add(:hours_benefit, 'El tiempo de beneficio debe ser mayor que 0')
      errors.add(:minutes_benefit, 'El tiempo de beneficio debe ser mayor que 0')
      errors.add(:seconds_benefit, 'El tiempo de beneficio debe ser mayor que 0')
    end
  end

end
