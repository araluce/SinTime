class AddAttachment < ActiveRecord::Migration[5.1]
  def change
    add_attachment :users, :avatar, after: :id
    add_attachment :admins, :avatar, after: :id
    add_attachment :exercises, :icon, after: :cycling_rate
    add_attachment :districts, :logo, after: :name
  end
end
