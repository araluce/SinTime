class Exercise::LevelTest < Exercise

  validates :title, presence: true

  def to_s
    title
  end
end
