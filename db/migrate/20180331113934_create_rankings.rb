class CreateRankings < ActiveRecord::Migration[5.1]
  def change
    create_table :rankings do |t|
      t.belongs_to :user
      t.belongs_to :district
      t.integer :position
      t.integer :midchronic
      t.string :type
      t.timestamps
    end
  end
end
