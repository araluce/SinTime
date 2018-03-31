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
        @districts = Ranking::District.where(created_at: (Date.today.beginning_of_month)..(Date.today.end_of_month)).order(position: :desc)
      end

    end
  end
end