class CreateUserRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :user_ranges do |t|
      t.attachment :icon
      t.string :range_text
      t.integer :min_score, default: 0
      t.timestamps
    end
  end
end
