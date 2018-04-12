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

        model_district.all.each do |district|
          @current_districts << district.ranking_districts.last
        end

        model_district.all.each do |district|
          @districts << district.ranking_districts.last
        end

      end

      def model_ranking_district
        ::Ranking::District
      end

      def model_district
        ::District
      end

    end
  end
end