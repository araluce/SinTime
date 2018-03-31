class RankingService
  class << self

    def users_ranking
      get_users_by_position
      @users.each_with_index do |user, index|
        user.ranking_users.create(position: index+1)
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

    def get_users_by_position
      @users = User.normal_users.joins(:banking_movements).where('banking_movements.created_at >= ?', 1.week.ago).group(:user_id).order('sum(banking_movements.time_before) DESC')
    end

    def districts_ranking
      results = get_districts_by_position.sort_by {|object| object[:points]}

      results.each_with_index do |district_ranking, index|
        district = District.find(district_ranking[:district_id])
        district.ranking_districts.create(position: index + 1)

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

    def get_districts_by_position
      results = []
      District.find_each do |district|
        if district.users.any?
          points = district.users.joins(:banking_movements).where('banking_movements.created_at >= ?', 1.week.ago).sum('banking_movements.time_before') / district.users.count
          results << {district_id: district.id, points: points}
        end
      end
      results
    end

  end
end