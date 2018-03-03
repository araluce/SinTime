class CreateExerciseBenefitScores < ActiveRecord::Migration[5.1]
  def change
    create_table :exercise_benefit_scores do |t|
      t.references :exercise
      t.references :score
      t.integer :time_benefit, default: 0
      t.timestamps
    end
  end
end
