class CreateExerciseSports < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_sports do |t|
      t.integer :time_running, default: 0
      t.integer :time_cycling, default: 0
      t.decimal :speed, precision: 5, scale: 2
      t.decimal :pace, precision: 5, scale: 2

      t.timestamps
    end

    add_reference :activity_logs, :exercise_sport
  end
end
