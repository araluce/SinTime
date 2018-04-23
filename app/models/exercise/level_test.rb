class Exercise::LevelTest < Exercise

  validates :title, presence: true
  validates :max_applicants, numericality: {allow_nil: false, allow_blank: false, greater_than: 0}

  def to_s
    title
  end

  def is_complete?
    exercise_users.count < max_applicants ? false : true
  end

  class << self
    def completed
      all_completed = []
      all.map {|level_test| all_completed << level_test if level_test.is_complete?}
      all_completed
    end

    def uncompleted
      all_uncompleted = []
      all.map {|level_test| all_uncompleted << level_test unless level_test.is_complete?}
      all_uncompleted
    end
  end
end
