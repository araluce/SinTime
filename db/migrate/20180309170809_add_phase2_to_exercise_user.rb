class AddPhase2ToExerciseUser < ActiveRecord::Migration[5.1]
  def change
    add_attachment :exercise_users, :second_file, after: :file_updated_at
  end
end
