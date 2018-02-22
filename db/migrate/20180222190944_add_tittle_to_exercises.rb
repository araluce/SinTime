class AddTittleToExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :title, :text, after: :type
  end
end
