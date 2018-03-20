class MessageView < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :viewed, :boolean, default: false, after: :message
  end
end
