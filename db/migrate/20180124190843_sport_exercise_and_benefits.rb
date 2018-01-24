class SportExerciseAndBenefits < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :time_benefit, :integer, after: :statement, default: 1
    add_column :exercises, :time_cycling, :integer, after: :time_benefit, default: 1
    add_column :exercises, :time_running, :integer, after: :time_cycling, default: 1
    add_column :exercises, :running_rate, :decimal, precision: 12, scale: 6, after: :time_running, default: 0
    add_column :exercises, :cycling_rate, :decimal, precision: 12, scale: 6, after: :running_rate, default: 0
  end
end
