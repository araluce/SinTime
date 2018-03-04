class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable

  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :district, inverse_of: :users, optional: true

  has_and_belongs_to_many :tweeters, class_name: 'Tweeter'

  has_many :backpacks, class_name: 'Twitter::Backpack', inverse_of: :user, dependent: :destroy
  has_many :tweets, class_name: 'Tweet', through: :backpacks, inverse_of: :users

  has_many :shared_backpacks, class_name: 'Twitter::Backpack', inverse_of: :user_share, dependent: :destroy

  has_many :exercise_users, inverse_of: :user, dependent: :destroy
  has_many :exercises, inverse_of: :users, through: :exercise_users

  has_many :banking_movements, inverse_of: :user, dependent: :destroy

  has_one :user_runtastic, inverse_of: :user, dependent: :destroy
  accepts_nested_attributes_for :user_runtastic, reject_if: :all_blank, allow_destroy: true

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ActionController::Base.helpers.asset_path('avatar.png')
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  scope :inactive, -> {where(status: 0)}
  scope :alive, -> {where(status: 1)}
  scope :dead, -> {where(status: 2)}
  scope :holidays, -> {where(status: 3)}
  scope :arrested, -> {where(status: 4)}
  scope :end, -> {where(status: 5)}
  scope :in_clan, -> {where.not(district: nil)}

  enum status: %w(Inactivo Vivo Fallecido Vacaciones Detenido Finalizado), _prefix: true

  validates :alias, uniqueness: true
  validates :alias, format: {with: /\A[a-z]+\z/i}

  attr_accessor :dni_list

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

  def full_name
    "#{name} #{lastname}"
  end

  def tweets_count
    backpacks.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).count
  end

  def to_s
    if full_name.present?
      full_name
    else
      email
    end
  end

end