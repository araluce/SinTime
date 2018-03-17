class CreateChatrooms < ActiveRecord::Migration[5.1]
  def change
    create_table :chatrooms do |t|
      t.references :district
      t.references :user_1
      t.references :user_2
      t.references :admin
      t.string :type
      t.timestamps
    end
  end
end
