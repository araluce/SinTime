class RefactorMessages < ActiveRecord::Migration[5.1]
  def change
    Message.find_each do |message|
      message.update_columns(message: message.message.encode('UTF-8'))
    end
  end
end
