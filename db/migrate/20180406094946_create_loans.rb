class CreateLoans < ActiveRecord::Migration[5.1]
  def change
    create_table :loans do |t|
      t.belongs_to :user
      t.integer :loan
      t.integer :remaining
      t.integer :share, default: 4

      t.timestamps
    end
  end
end
