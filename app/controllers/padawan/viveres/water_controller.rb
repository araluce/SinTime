module Padawan
  module Viveres
    class WaterController < Padawan::ViveresController
      layout 'padawan'
      before_action :set_objects
      before_action :percentage

      include TimeHelper

      def model
        Exercise::Feeding
      end

      def index
        @object = model.new
      end

      private

      def set_objects
        @objects_clan = model.clan.water.order(created_at: :desc)

        @objects_individual = current_user.water_deliveries_individual.map(&:exercise)

        if @objects_individual.empty?
          set_random_exercise
        end
      end

      def percentage
        tsb_default = Constant.find_by_key('tiempo sin beber');
        tsb_default_time = seconds_to_duration(tsb_default.value)

        @percentage = 1 - ((datetime_to_seconds(DateTime.now) - datetime_to_seconds(current_user.tsb)) / tsb_default_time.value.to_f)
        @percentage = 0 if @percentage < 0
        @percentage = 1 if @percentage > 1
        @percentage = 1 if current_user.is_in_holidays?
      end

      def set_random_exercise
        tries = model.water.individual.count
        tries.times do
          my_exercises_done = current_user.exercise_users.pluck(:exercise_id)
          @random_exercise = model.water.individual.offset(rand(model.water.individual.count)).first
          break unless my_exercises_done.include? @random_exercise.id
        end
      end

    end
  end
end