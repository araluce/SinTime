class ActivityIdOutOfRange < ActiveRecord::Migration[5.1]
  def change
    change_column :activity_logs, :activity_id, :integer, limit: 8
    change_column :activity_logs, :user_runtastic_id, :integer, limit: 8
  end
end
