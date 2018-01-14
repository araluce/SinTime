class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :district, inverse_of: :users, optional: true

  scope :inactive, -> {where(status: 0)}
  scope :alive, -> {where(status: 1)}
  scope :dead, -> {where(status: 2)}
  scope :holidays, -> {where(status: 3)}
  scope :arrested, -> {where(status: 4)}
  scope :end, -> {where(status: 5)}

  enum status: %w(Inactivo Vivo Fallecido Vacaciones Detenido Finalizado), _prefix: true

  def inactive?
    self.status == 'Inactivo'
  end

  def alive?
    self.status == 'Vivo'
  end

  def dead?
    self.status == 'Fallecido'
  end

  def holidays?
    self.status == 'Vacaciones'
  end

  def arrested?
    self.status == 'Detenido'
  end

  def end?
    self.status == 'Finalizado'
  end

  def logged?
    current_sign_in_at > last_sign_in_at
  end

  def name_complete
    "#{name} #{lastname}"
  end

  def to_s
    if name_complete.present?
      name_complete
    else
      email
    end
  end

end