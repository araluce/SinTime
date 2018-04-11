class UserHolidays < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :have_holidays, :boolean, default: true, after: :xp
  end
end
