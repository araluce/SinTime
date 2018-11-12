class PayService
  class << self
    include TimeHelper

    def user_pay_reason(user, quantity, reason)
      result_time = user.tdv - seconds_to_duration(quantity)
      user.update_columns(tdv_holidays_ref: user.tdv_holidays_ref - quantity) if user.is_in_holidays?
      pay_reason(user, result_time, reason)
    end

    def system_pay_reason(user, quantity, reason)
      result_time = user.tdv + seconds_to_duration(quantity)
      user.update_columns(tdv_holidays_ref: user.tdv_holidays_ref + quantity) if user.is_in_holidays?
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
      exercise_feeding = exerciseuser.exercise.type == 'Exercise::Feeding'
      tree_days = exerciseuser.exercise.time_benefit == 259200

      if exerciseuser.exercise.is_clan?
        exerciseuser.user.district.users.each do |user|
          have_card = user.user_privileges_cards.where(privileges_card: PrivilegesCard.find_by_identifier(8), active: true)
          multiplier = 1
          if have_card.any? && exercise_feeding && tree_days
            multiplier = 2
            have_card.first.update_columns(active: false)
          end
          system_pay_reason(user, exerciseuser.exercise.benefit_scores.find_by(score: exerciseuser.score).time_benefit * multiplier, multiplier == 2 ? 'Reto calificado x 2' : 'Reto calificado')
        end
      else
        have_card = exerciseuser.user.user_privileges_cards.where(privileges_card: PrivilegesCard.find_by_identifier(8), active: true)
        multiplier = 1
        if have_card.any? && exercise_feeding && tree_days
          multiplier = 2
          have_card.first.update_columns(active: false)
        end
        system_pay_reason(exerciseuser.user, exerciseuser.exercise.benefit_scores.find_by(score: exerciseuser.score).time_benefit * multiplier, multiplier == 2 ? 'Reto calificado x 2' : 'Reto calificado')
      end
    end

    def pay_sport(user, exercise)
      system_pay_reason(user, exercise.time_benefit, 'Reto deportivo')
      p "Pagado a #{user.alias} con id: #{user.id} una cantidad de #{exercise.time_benefit} segundos"
    end

    def generate_movement(user, exercise, reason, time_after)
      user.banking_movements.create(reason: reason, exercise: exercise, time_before: (user.tdv.to_time - DateTime.now), time_after: (time_after.to_time-DateTime.now))
      user.update_columns(tdv: time_after)
    end

  end
end