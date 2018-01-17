class CreateExerciseOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_options do |t|
      t.text :option
      t.boolean :right, default: false

      t.timestamps
    end
  end
end
