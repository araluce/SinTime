class CardService
  class << self
    include CardsHelper

    def night_break_card
      PrivilegesCard.find_by(identifier: 4)
    end

    def night_break_perform_user(user)
      PayService.system_pay_reason(user, 8.hours.to_i, 'Parón nocturno')
    end

    def night_break_perform
      UserPrivilegesCard.where(privileges_card: night_break_card).each do |user_privileges_card|
        night_break_perform_user(user_privileges_card.user) if card_is_valid?(user_privileges_card)

      end
    end

    def ti_capsule_card
      PrivilegesCard.find_by(identifier: 6)
    end

    def ti_capsule_perform_user(user)
      user.update_columns(tdv: user.tdv + 8.hours)
    end

    def ti_capsule_perform
      UserPrivilegesCard.where(privileges_card: ti_capsule_card).each do |user_privileges_card|
        night_break_perform_user(user_privileges_card.user) if card_is_valid?(user_privileges_card)
      end
    end

  end
end