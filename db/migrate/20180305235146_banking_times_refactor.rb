class BankingTimesRefactor < ActiveRecord::Migration[5.1]
  def change
    change_column :banking_movements, :time_before, :integer
    change_column :banking_movements, :time_after, :integer
  end
end
