class PayService
  class << self
    include TimeHelper

    def pay_exercise(user, exercise)
      result_time = user.tdv - seconds_to_duration(exercise.time_benefit)
      generate_movement(user, exercise, result_time)
    end

    def rewind_exercise(user, exercise)
      result_time = user.tdv + seconds_to_duration(exercise.time_benefit)
      generate_movement(user, exercise, result_time)
    end

    def generate_movement(user, exercise, time_after)
      user.banking_movements.create(exercise: exercise, time_before: user.tdv.to_time, time_after: time_after.to_time)
      user.update_columns(tdv: time_after)
    end

  end
end