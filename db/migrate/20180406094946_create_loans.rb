class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.belongs_to :user
      t.integer :time_loan, default: 0
      t.integer :time_remaining, default: 0
      t.integer :share, default: 4
      t.integer :share_remaining

      t.timestamps
    end
  end
end
