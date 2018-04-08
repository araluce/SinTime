class InteresetForLoans < ActiveRecord::Migration[5.1]
  def change
    add_column :loans, :interest, :decimal, precision: 12, scale: 6, default: 0.33, after: :time_remaining
  end
end
