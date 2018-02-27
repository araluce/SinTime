class CreateBankingMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :banking_movements do |t|
      t.references :user
      t.references :exercise
      t.time :time_after
      t.time :time_before
      t.timestamps
    end
  end
end
