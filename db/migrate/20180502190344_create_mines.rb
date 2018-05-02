class CreateMines < ActiveRecord::Migration[5.1]
  def change
    create_table :mines do |t|
      t.string :statement
      t.string :code
      t.integer :time_benefit, default: 1
      t.datetime :valid_until
      t.timestamps
    end
  end
end
