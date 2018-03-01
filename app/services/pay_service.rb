class PayService
  class << self
    include TimeHelper

    def pay_exercise(user, exercise, reason)
      result_time = user.tdv - seconds_to_duration(exercise.time_benefit)
      generate_movement(user, exercise, reason, result_time)
    end

    def rewind_exercise(user, exercise, reason)
      result_time = user.tdv + seconds_to_duration(exercise.time_benefit)
      generate_movement(user, exercise, reason, result_time)
    end

    def pay_score(exerciseuser)
      result_time = exerciseuser.user.tdv + seconds_to_duration(exerciseuser.score.time_benefit)
      generate_movement(exerciseuser.user, exerciseuser.exercise, 'Reto calificado', result_time)
    end

    def generate_movement(user, exercise, reason, time_after)
      user.banking_movements.create(reason: reason, exercise: exercise, time_before: user.tdv.to_time, time_after: time_after.to_time)
      user.update_columns(tdv: time_after)
    end

  end
end