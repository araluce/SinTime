module Padawan
  module PadawanInfo
    class RangoJediController < Padawan::PadawanInfoController
      layout 'padawan'
      before_action :get_objects

      def index
      end

      private

      def get_objects
        @objects = User.normal_users.joins(:banking_movements).where('banking_movements.created_at >= ?', 1.week.ago).group(:user_id).order('sum(banking_movements.time_before) DESC')
        @current_districts = []
        @districts = []

        District.all.each do |district|
          @current_districts << ::Ranking::District.where(district: district).last
        end

        District.all.each do |district|
          @districts << ::Ranking::District.where(classification: true, district: district).last
        end

      end

    end
  end
end