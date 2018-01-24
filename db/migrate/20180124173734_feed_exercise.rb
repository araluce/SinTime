class FeedExercise < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :feeding_type, :integer, default: 0
  end
end
