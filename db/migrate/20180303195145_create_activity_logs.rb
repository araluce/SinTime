class CreateActivityLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :activity_logs do |t|
      t.references :user_runtastic
      t.integer :activity_id
      t.date :date
      t.integer :activity_type
      t.integer :duration
      t.integer :distance
      t.decimal :average_speed, precision: 5, scale: 2
      t.datetime :start_time
      t.datetime :end_time
      t.datetime :activity_created_at
      t.datetime :activity_updated_at
      t.boolean :completed
      t.text :data
      t.timestamps
    end
  end
end
