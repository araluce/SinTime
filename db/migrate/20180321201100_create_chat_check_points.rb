class CreateChatCheckPoints < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_check_points do |t|
      t.references :user
      t.references :admin
      t.references :chatroom
      t.timestamps
    end
  end
end
