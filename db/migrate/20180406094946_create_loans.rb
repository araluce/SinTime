class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.belongs_to :user
      t.integer :time_loan
      t.integer :time_remaining
      t.integer :share, default: 4

      t.timestamps
    end
  end
end
