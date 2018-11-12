class LoanService
  class << self
    include TimeHelper

    def pay_share(loan)
      PayService.user_pay_reason(loan.user, loan.time_per_share, 'Cuota pagada')
      loan.update_columns(share_remaining: loan.share_remaining - 1, time_remaining: loan.time_remaining - loan.time_per_share)
    end

    def pay_all(loan)
      PayService.user_pay_reason(loan.user, loan.time_remaining, 'Préstamo pagado al completo')
      loan.update_columns(share_remaining: 0, time_remaining: 0)
    end

  end
end