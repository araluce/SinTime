class PayService
  class << self
    include TimeHelper

    def pay_exercise(user, exercise)
      result_time = user.tdv - seconds_to_duration(exercise.time_benefit)
      user.banking_movements.create(exercise: exercise, time_before: user.tdv.to_time, time_after: result_time.to_time)
      user.update_columns(tdv: result_time)
    end

  end
end