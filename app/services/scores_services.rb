class ScoresServices
  class << self

    def max_score
      [
          Score.find_by(title: 'Tú sí que vales'),
          Score.find_by(title: 'Rozando El Larguero'),
          Score.find_by(title: 'Para Quitarse El Sombrero!'),
      ]
    end

    def has_max_score_last_week?(user)
      ExerciseUser.where(updated_at: (DateTime.now.beginning_of_week - 1.week)..(DateTime.now.end_of_week - 1.week), user: user, score: max_score).any?
    end

    def has_max_score_week?(user, week)
      ExerciseUser.where(updated_at: (DateTime.now.beginning_of_week - week.week)..(DateTime.now.end_of_week - week.week), user: user, score: max_score).any?
    end

  end
end