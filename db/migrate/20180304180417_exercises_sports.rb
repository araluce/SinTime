class ExercisesSports < ActiveRecord::Migration[5.1]
  def change
    drop_table :exercise_sports

    rename_column :exercises, :running_rate, :speed
    rename_column :exercises, :cycling_rate, :pace
  end
end
