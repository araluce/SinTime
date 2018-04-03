class RefactorBetOptionUser < ActiveRecord::Migration[5.1]
  def change
    rename_column :bet_option_users, :time_wagered, :time_bet
    change_column :bet_option_users, :time_bet, :integer, default: 0
  end
end
