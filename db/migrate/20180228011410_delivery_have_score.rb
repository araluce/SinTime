class DeliveryHaveScore < ActiveRecord::Migration[5.1]
  def change
    add_column :exercise_users, :score_id, :bigint, after: :status
  end
end
