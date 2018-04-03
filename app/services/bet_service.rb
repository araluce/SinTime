class BetService
  class << self

    def pay_bet(bet)
      winners(bet).each do |user|
        pay_bet_user(bet, user)
      end
    end

    def pay_bet_user(bet, user)
      return if my_benefit(bet, user) == 0
      PayService.system_pay_reason(user, my_benefit(bet, user), 'Apuesta ganadora')
    end

    def total_time(bet)
      time_wagered = 0

      bet.options.each do |option|
        time_wagered += option.bet_users.each.inject(0) do |total, bet_user|
          total + bet_user.time_bet
        end
      end

      time_wagered
    end

    def my_benefit(bet, user)
      return 0 if  my_right_bets(bet, user).empty?
      my_time_wagered(bet, user) + (total_time(bet) / winners(bet).count)
    end

    def my_right_bets(bet, user)
      bet.options.right_options.joins(:bet_users).where(bet_option_users: {user_id: user.id})
    end

    def my_time_wagered(bet, user)
      return 0 unless my_right_bets(bet, user).any?
      BetOptionUser.where(bet_option: my_right_bets(bet, user), user: user).pluck(:time_bet).inject(0){ |sum,x| sum + x }
    end

    def winners(bet)
      users = []
      bet.options.right_options.each do |option|
        option.bet_users.map {|bet_user| users << bet_user.user unless users.include?(bet_user.user)}
      end
      users
    end

  end
end