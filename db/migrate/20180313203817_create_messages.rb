class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :chat_room
      t.references :user
      t.references :admin

      t.text :message

      t.timestamps
    end
  end
end
