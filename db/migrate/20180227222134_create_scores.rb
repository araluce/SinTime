class CreateScores < ActiveRecord::Migration[5.1]
  def change
    create_table :scores do |t|
      t.string :title
      t.integer :time_benefit, default: 0
      t.attachment :icon
      t.timestamps
    end
  end
end
