class PayService
  class << self
    include TimeHelper

    def user_pay_reason(user, quantity, reason)
      result_time = user.tdv - seconds_to_duration(quantity)
      pay_reason(user, result_time, reason)
    end

    def system_pay_reason(user, quantity, reason)
      result_time = user.tdv + seconds_to_duration(quantity)
      pay_reason(user, result_time, reason)
    end

    def pay_reason(user, time_after, reason)
      user.banking_movements.create(reason: reason, time_before: (user.tdv.to_time - DateTime.now), time_after: (time_after.to_time-DateTime.now))
      user.update_columns(tdv: time_after)
    end

    def pay_exercise(user, exercise, reason)
      result_time = user.tdv - seconds_to_duration(exercise.time_benefit)
      generate_movement(user, exercise, reason, result_time)
    end

    def rewind_exercise(user, exercise, reason)
      result_time = user.tdv + seconds_to_duration(exercise.time_benefit)
      generate_movement(user, exercise, reason, result_time)
    end

    def pay_score(exerciseuser)
      if exerciseuser.exercise.is_clan?
        exerciseuser.user.district.users.each do |user|
          result_time = user.tdv + seconds_to_duration( exerciseuser.exercise.benefit_scores.find_by(score: exerciseuser.score).time_benefit )
          generate_movement(user, exerciseuser.exercise, 'Reto calificado', result_time)
        end
      else
        result_time = exerciseuser.user.tdv + seconds_to_duration( exerciseuser.exercise.benefit_scores.find_by(score: exerciseuser.score).time_benefit )
        generate_movement(exerciseuser.user, exerciseuser.exercise, 'Reto calificado', result_time)
      end
    end

    def pay_sport(user, exercise)
      result_time = user.tdv + seconds_to_duration(exercise.time_benefit)
      p "Pagado a #{user.alias} con id: #{user.id} una cantidad de #{exercise.user.time_benefit} segundos"
    end

    def generate_movement(user, exercise, reason, time_after)
      user.banking_movements.create(reason: reason, exercise: exercise, time_before: (user.tdv.to_time - DateTime.now), time_after: (time_after.to_time-DateTime.now))
      user.update_columns(tdv: time_after)
    end

  end
end