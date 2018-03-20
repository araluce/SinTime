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

  has_many :messages, inverse_of: :user, dependent: :destroy

  has_many :chat_admins, class_name: '::Chat::Admin', inverse_of: :user_1, foreign_key: :user_1_id, dependent: :destroy

  has_attached_file :avatar, styles: { medium: '300x300>', thumb: '100x100>' }, default_url: ActionController::Base.helpers.image_path('avatar.png')
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  scope :inactive, -> {where(status: 0)}
  scope :alive, -> {where(status: 1)}
  scope :dead, -> {where(status: 2)}
  scope :holidays, -> {where(status: 3)}
  scope :arrested, -> {where(status: 4)}
  scope :end, -> {where(status: 5)}
  scope :in_clan, -> {where.not(district: nil)}
  scope :loggeds, -> {where(logged: true)}
  scope :disconnected, -> {where(logged: false)}
  scope :normal_users, -> {where(untouchable: false)}

  scope :messages_for_me, -> {joins(:banking_movements).where('banking_movements.created_at >= ?', 1.week.ago).group(:user_id).order('sum(banking_movements.time_before) DESC')}

  enum status: %w(Inactivo Vivo Fallecido Vacaciones Detenido Finalizado), _prefix: true

  validates :alias, uniqueness: true
  validates :alias, format: {with: /\A[a-zA-Z0-9]+\z/i}

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
    logged
  end

  def full_name
    "#{name} #{lastname}"
  end

  def tweets_count
    backpacks.where('created_at BETWEEN ? AND ?', DateTime.now.beginning_of_day, DateTime.now.end_of_day).count
  end

  def yesterday_tweets_count
    backpacks.where('created_at BETWEEN ? AND ?', DateTime.yesterday.beginning_of_day, DateTime.yesterday.end_of_day).count
  end

  def to_s
    if full_name.present?
      full_name
    else
      email
    end
  end

  def food_deliveries
    exercise_users.joins(:exercise).where('exercises.feeding_type = 0')
  end

  def water_deliveries
    exercise_users.comprado.joins(:exercise).where('exercises.feeding_type = 1')
  end

  def individual_chats
    Chat::Individual.where(user_1_id: self.id).or(Chat::Individual.where(user_2_id: self.id))
  end

  def messages_not_reads
    individual_chats.joins(:messages).where('user_id != ? AND viewed=?', self.id, false).count
  end

  def chat_clan
    Chat::Clan.find_by(district: district) rescue nil
  end

  def chat_admins
    Chat.Admin.where(user_1: self)
  end

end