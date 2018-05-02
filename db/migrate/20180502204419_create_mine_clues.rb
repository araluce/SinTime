class CreateMineClues < ActiveRecord::Migration[5.1]
  def change
    create_table :mine_clues do |t|
      t.belongs_to :mine
      t.string :clue
      t.timestamps
    end
  end
end
