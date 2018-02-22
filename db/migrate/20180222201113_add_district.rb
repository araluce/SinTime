class AddDistrict < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :district, :boolean, after: :time_benefit, default: false
  end
end
