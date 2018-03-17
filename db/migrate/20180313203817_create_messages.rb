class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :chatroom
      t.references :user
      t.references :admin

      t.text :message

      t.timestamps
    end
  end
end
