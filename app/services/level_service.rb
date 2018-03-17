class LevelService
  class << self

    def next_level(level)
      level += 1
    end

    def profit_xp(level)
      level > 3 ? 3 : level
    end

    def level_up(user)
      User.update_columns(level: next_level(user.level), xp: profit_xp(next_level(user.level)))
    end

  end
end