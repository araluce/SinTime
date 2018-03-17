class ScoresServices
  class << self

    def max_score
      Score.find_by(title: 'Tú sí que vales')
    end

    def has_max_score_last_week?(user)
      ExerciseUser.where(updated_at: Date.today.beginning_of_week..Date.today.end_of_week, user: user, score: max_score).any?
    end

  end
end