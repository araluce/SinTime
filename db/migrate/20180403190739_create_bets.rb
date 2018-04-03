class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.text :bet
      t.boolean :active, default: false
      t.boolean :open, default: true
      t.timestamps
    end
  end
end
