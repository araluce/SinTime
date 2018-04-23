class AddMaxApplicants < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :max_applicants, :integer, after: :icon_file_name
  end
end
