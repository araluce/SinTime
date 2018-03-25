module CardsHelper

  CARD_TO_HUMAN = {
      '1' => 'donation',
      '2' => 'free_clue',
      '3' => 'bounty_hunter',
      '4' => 'night_break',
      '5' => 'full_energy',
      '6' => 'ti_capsule',
      '7' => 'multiply_by_two',
      '8' => 'double_benefit',
      '9' => 'personal_retirement'
  }

  def check_card_buy
    send(CARD_TO_HUMAN[@card.identifier])
  end

  def card_is_valid?(user_privilege_card)
    @user_privilege_card = user_privilege_card
    send("#{CARD_TO_HUMAN[@user_privilege_card.privileges_card.identifier]}_is_valid?")
  end

  def donation
    user = User.find_by(id: @object.user_to_id)

    if user
      return @error = 'El padawan elegido por tí tiene más de 7 días de vida' if (user.tdv - 7.days) > DateTime.now
      return @error = 'No puedes usar esta carta contra tí mismo' if user == current_user
      pay_xp
      PayService.system_pay_reason(user, 259200, "Donación con carta de privilegio realizada por @#{current_user.alias.downcase}")
    else
      @error = 'Error inesperado, no se ha encontrado al padawan'
    end
  end

  def free_clue

  end

  def bounty_hunter
    if current_user.user_privileges_cards.where(privileges_card: @card, created_at: (DateTime.now-1.week)..(DateTime.now)).any?
      @error = 'Ya tienes una carta libre de cazarecompensas esta semana'
    else
      pay_xp
    end
  end

  def night_break

  end

  def full_energy

  end

  def ti_capsule

  end

  def multiply_by_two

  end

  def double_benefit

  end

  def personal_retirement

  end

  def donation_is_valid?
    false
  end

  def free_clue_is_valid?
    true
  end

  def bounty_hunter_is_valid?
    @user_privilege_card.created_at >= DateTime.now-1.week
  end

  def night_break_is_valid?
    true
  end

  def full_energy_is_valid?
    true
  end

  def ti_capsule_is_valid?
    true
  end

  def multiply_by_two_is_valid?
    true
  end

  def double_benefit_is_valid?
    true
  end

  def personal_retirement_is_valid?
    true
  end

  def pay_xp
    @error = 'No tienes suficientes xp' unless LevelService.user_pay_xp(current_user, @card.xp_cost)
  end

end