class TdvHolidays < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :tdv_holidays, :datetime, after: :tdv, default: DateTime.now - 1.days
    add_column :users, :tdv_holidays_ref, :datetime, after: :tdv_holidays, default: DateTime.now
  end
end

