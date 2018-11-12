class MineService
  class << self

    def pay_mine(mine)
      benefit = (mine.time_benefit / mine.user_mines.count) rescue 0
      return if benefit.zero?

      mine.user_mines.each do |user_mine|
        user = user_mine.user
        PayService.system_pay_reason(user, benefit, 'Zapador')
      end
    end

  end
end