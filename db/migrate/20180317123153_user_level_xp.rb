class UserLevelXp < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :level, :integer, default: 0, after: :tsb
    add_column :users, :xp, :integer, default: 0, after: :level
  end
end
