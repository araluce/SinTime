class CreateUserMines < ActiveRecord::Migration[5.1]
  def change
    create_table :user_mines do |t|
      t.belongs_to :user
      t.belongs_to :mine
      t.timestamps
    end
  end
end
