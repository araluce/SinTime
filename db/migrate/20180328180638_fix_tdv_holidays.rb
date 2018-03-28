class FixTdvHolidays < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :tdv_holidays_ref, :datetime
    add_column :users, :tdv_holidays_ref, :integer, after: :tdv_holidays

    User.find_each do |user|
      user.update_columns(tdv_holidays_ref: (user.tdv - 4.days - 4.hours - DateTime.now).to_i)
    end
  end
end
