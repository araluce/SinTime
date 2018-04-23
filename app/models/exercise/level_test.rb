class Exercise::LevelTest < Exercise

  validates :title, presence: true
  validates :max_applicants, numericality: {allow_nil: false, allow_blank: false, greater_than: 0}

  def to_s
    title
  end
end
