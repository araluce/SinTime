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
      ExerciseUser.where(updated_at: (Date.today.beginning_of_week - 1.week)..(Date.today.end_of_week - 1.week), user: user, score: max_score).any?
    end

  end
end