class ReasonForBankingMovements < ActiveRecord::Migration[5.1]
  def change
    add_column :banking_movements, :reason, :string, after: :exercise_id
  end
end
