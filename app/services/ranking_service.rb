class RankingService
  class << self

    def users_ranking
      users = User.all.map{|user| {user: user, score: user.banking_movements.where(created_at: DateTime.now.beginning_of_month-1.month ..DateTime.now.end_of_month-1.month).map {|banking_movement| banking_movement.seconds_difference }.sum}}.sort_by{|obj| -obj[:score]}

      users.each_with_index do |user_ranking, index|
        user = user_ranking[:user]
        if index+1 == 1
          PayService.system_pay_reason(user, 172800, 'Primer puesto en la clasificación individual')
          p "@#{user.alias} ha sido premiado con 172800s por primer puesto en la clasificación individual"
        elsif index+1 == 2
          PayService.system_pay_reason(user, 129600, 'Segundo puesto en la clasificación individual')
          p "@#{user.alias} ha sido premiado con 129600s por segundo puesto en la clasificación individual"
        elsif index+1 == 3
          PayService.system_pay_reason(user, 86400, 'Tercer puesto en la clasificación individual')
          p "@#{user.alias} ha sido premiado con 86400s por tercer puesto en la clasificación individual"
        end
      end
    end

    def districts_ranking
      @monthly_district = District.all.map{|district| {district: district, score: district.users.map{|user| user.banking_movements.where(created_at: DateTime.now.beginning_of_month..DateTime.now.end_of_month).map {|banking_movement| banking_movement.seconds_difference }}.flatten.sum}}.sort_by{|obj| -obj[:score]}

      @monthly_district.each_with_index do |district_ranking, index|
        district = district_ranking[:district]
        p "El distrito #{district} ##{district.id}ha quedado en posición #{index + 1}"
        district.users.find_each do |user|
          if index+1 == 1
            PayService.system_pay_reason(user, 172800, 'Primer puesto en la clasificación de distrito')
            p "@#{user.alias} ha sido premiado con 172800s por primer puesto en la clasificación de distrito"
          elsif index+1 == 2
            PayService.system_pay_reason(user, 129600, 'Segundo puesto en la clasificación de distrito')
            p "@#{user.alias} ha sido premiado con 129600s por segundo puesto en la clasificación de distrito"
          elsif index+1 == 3
            PayService.system_pay_reason(user, 86400, 'Tercer puesto en la clasificación de distrito')
            p "@#{user.alias} ha sido premiado con 86400s por tercer puesto en la clasificación de distrito"
          end
        end
      end
    end

  end
end