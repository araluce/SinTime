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
    if current_user.user_privileges_cards.where(privileges_card: @card, created_at: (DateTime.now-1.week)..(DateTime.now)).any?
      @error = 'Ya tienes una carta de parón nocturno esta semana'
    else
      pay_xp
    end
  end

  def full_energy

  end

  def ti_capsule
    if current_user.tdv > DateTime.now + 7.days
      @error = 'No puedes comprar esta carta, tienes más de 7 días de vida'
    else
      pay_xp
      current_user.update_columns(tdv: current_user.tdv + 3.days)
    end
  end

  def multiply_by_two
    if current_user.user_privileges_cards.where(privileges_card: @card, created_at: (DateTime.now-1.week)..(DateTime.now)).any?
      @error = 'Ya tienes una carta multiplica x 2 esta semana'
    else
      pay_xp
    end
  end

  def double_benefit
    if current_user.user_privileges_cards.where(privileges_card: @card, active: true).any?
      @error = 'Ya tienes una carta de doble beneficio sin usar'
    else
      pay_xp
    end
  end

  def personal_retirement
    if current_user.is_in_holidays?
      @error = 'Ya estás de vacaciones'
    else
      pay_xp
      if @error.nil?
        holidays_duration = 604800
        tdv = current_user.tdv + holidays_duration
        tsc = DateTime.now + holidays_duration
        tsb = DateTime.now + holidays_duration
        tdv_holidays = DateTime.now + holidays_duration
        tdv_holidays_ref = (current_user.tdv - DateTime.now).to_i
        current_user.update_columns(tdv: tdv, tsc: tsc, tsb: tsb, tdv_holidays: tdv_holidays, tdv_holidays_ref: tdv_holidays_ref)
      end
    end
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
    @user_privilege_card.created_at >= DateTime.now-1.week
  end

  def full_energy_is_valid?
    true
  end

  def ti_capsule_is_valid?
    false
  end

  def multiply_by_two_is_valid?
    @user_privilege_card.created_at >= DateTime.now-1.week
  end

  def double_benefit_is_valid?
    @user_privilege_card.active
  end

  def personal_retirement_is_valid?
    @user_privilege_card.created_at >= DateTime.now-1.week
  end

  def pay_xp
    @error = 'No tienes suficientes xp' unless LevelService.user_pay_xp(current_user, @card.xp_cost)
  end

end