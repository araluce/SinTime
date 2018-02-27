class CreateExerciseUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_users do |t|
      t.references :exercise
      t.references :user

      t.attachment :file
      t.integer :status, default: 0
      t.timestamps
    end
  end
end
