module Padawan
  module PadawanInfo
    class RangoJediController < Padawan::PadawanInfoController
      layout 'padawan'
      before_action :get_objects

      def index
      end

      private

      def get_objects
        @objects = User.all.order(tdv: :desc)
        @user = User.all.map{|user| {user: user, score: user.banking_movements.map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}
        @district = District.all.map{|district| {district: district, score: district.users.map{|user| user.banking_movements.map {|banking_movement| banking_movement.seconds_difference }}.flatten.sum}}.sort_by{|obj| -obj[:score]}
        @monthly_user = User.all.map{|user| {user: user, score: user.banking_movements.where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}
        @monthly_district = District.all.map{|district| {district: district, score: district.users.map{|user| user.banking_movements.where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).map {|banking_movement| banking_movement.seconds_difference }}.flatten.sum}}.sort_by{|obj| -obj[:score]}

      end

    end
  end
end