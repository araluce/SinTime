class ExerciseUser < ApplicationRecord
  include TimeHelper

  has_attached_file :file
  has_attached_file :second_file
  do_not_validate_attachment_file_type :file, :second_file

  belongs_to :user, inverse_of: :exercise_users
  belongs_to :exercise, inverse_of: :exercise_users
  belongs_to :score, optional: true

  enum status: %w[Comprado Entregado Corregido], _prefix: true

  validates :file, presence: true, on: :send_file
  validates :second_file, presence: true, on: :send_second_file
  validate :check_files, :check_delivery

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

  def update_second_file(attributes)
    self.assign_Attributes(attributes)
    self.save if valid?(:send_second_file)
  end

  private

  def check_files
    errors.add(:file, 'Antes de entregar la evidencia debes entregar la propuesta') if exercise.type_to_s == 'Happiness' && second_file && file.nil?
  end

  def check_delivery
    if second_file.exists?
      max_days = Constant.find_by_key('felicidad dias entre entregas').value.to_i
      final_date = file_updated_at + max_days.days
      rest_days = final_date - DateTime.now

      errors.add(:file, "Aún te quedan #{seconds_to_s(rest_days.to_i)} para poder entregar la evidencia")
    end
  end
end
