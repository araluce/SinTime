class RankingService
  class << self

    def users_ranking(month = false)
      if month
        get_users_by_position_last_month
      else
        get_users_by_position_last_current
      end
      @users.each_with_index do |user, index|
        user.ranking_users.create(position: index + 1, classification: month)
        if month
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
    end

    def get_users_by_position_last_month
      @users = User.normal_users.joins(:banking_movements).where('banking_movements.created_at >= ? AND banking_movements.created_at <= ?', DateTime.now.beginning_of_month - 1.month, DateTime.now.end_of_month - 1.month).group(:user_id).order('sum(banking_movements.time_before) DESC')
    end

    def get_users_by_position_last_current
      @users = User.normal_users.joins(:banking_movements).where('banking_movements.created_at >= ? AND banking_movements.created_at <= ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month).group(:user_id).order('sum(banking_movements.time_before) DESC')
    end

    def districts_ranking(month = false)
      if month
        results = get_districts_by_position.sort_by {|object| object[:points]}
      else
        results = get_districts_by_position_current.sort_by {|object| object[:points]}
      end

      results.each_with_index do |district_ranking, index|
        district = District.find(district_ranking[:district_id])
        district.ranking_districts.create(position: index + 1, classification: month)

        if month
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

    def get_districts_by_position
      results = []
      District.find_each do |district|
        if district.users.any?
          points = district.users.joins(:banking_movements).where('banking_movements.created_at >= ? AND banking_movements.created_at <= ?', DateTime.now.beginning_of_month - 1.month, DateTime.now.end_of_month - 1.month).sum('banking_movements.time_before') / district.users.count
          results << {district_id: district.id, points: points}
        end
      end
      results
    end

    def get_districts_by_position_current
      results = []
      District.find_each do |district|
        if district.users.any?
          points = district.users.joins(:banking_movements).where('banking_movements.created_at >= ? AND banking_movements.created_at <= ?', DateTime.now.beginning_of_month, DateTime.now.end_of_month).sum('banking_movements.time_before') / district.users.count
          results << {district_id: district.id, points: points}
        end
      end
      results
    end

  end
end