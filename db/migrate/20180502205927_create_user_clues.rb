class CreateUserClues < ActiveRecord::Migration[5.1]
  def change
    create_table :user_clues do |t|
      t.belongs_to :user
      t.belongs_to :clue
      t.timestamps
    end
  end
end
