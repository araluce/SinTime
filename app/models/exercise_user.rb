class ExerciseUser < ApplicationRecord

  has_attached_file :file
  validates_attachment_content_type :file, :content_type => ['application/pdf', 'application/zip', 'application/x-zip', 'application/x-zip-compressed','application/octet-stream','image/jpg','image/png']
  belongs_to :user, inverse_of: :exercise_users
  belongs_to :exercise, inverse_of: :exercise_users

  enum status: %w[Comprado Entregado Corregido], _prefix: true

  validates :file, presence: true, on: :send_file

  statuses.each do |status, index|
    scope status.downcase.to_sym, -> {where(status: status)}
    scope "no_#{status.downcase.to_sym}", -> {where.not(status: status)}

    define_method "is_#{status.downcase}?" do
      self.status == status
    end
  end

  def save_file!
    self.save if valid?(:send_file)
  end
end
