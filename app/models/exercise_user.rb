class ExerciseUser < ApplicationRecord

  has_attached_file :file
  has_attached_file :second_file
  validates_attachment_content_type :file, :second_file, :content_type => ['application/pdf', 'application/zip', 'application/x-zip', 'application/x-zip-compressed','application/octet-stream','image/jpg','image/png']

  belongs_to :user, inverse_of: :exercise_users
  belongs_to :exercise, inverse_of: :exercise_users
  belongs_to :score, optional: true

  enum status: %w[Comprado Entregado Corregido], _prefix: true

  validates :file, presence: true, on: :send_file
  validates :second_file, presence: true, on: :send_second_file

  statuses.each do |status, index|
    scope status.downcase.to_sym, -> {where(status: status)}
    scope "no_#{status.downcase.to_sym}", -> {where.not(status: status)}

    define_method "is_#{status.downcase}?" do
      self.status == status
    end
  end

  scope :deliveries, -> {where.not(file_file_name: nil)}
  scope :water, -> {joins(:exercise).where('exercises.feeding_type = 1')}
  scope :food, -> {joins(:exercise).where('exercises.feeding_type = 0')}
  scope :individual, -> {joins(:exercise).where('exercises.district = 0')}
  scope :clan, -> {joins(:exercise).where('exercises.district = 1')}
  scope :questionnaires, -> {joins(:exercise).where("exercises.type = 'Exercise::Questionnaire'")}
  scope :happiness, -> {joins(:exercise).where("exercises.type = 'Exercise::Happiness'")}

  def save_file!
    self.save if valid?(:send_file)
  end

  def save_second_file!
    self.save if valid?(:send_second_file)
  end
end
