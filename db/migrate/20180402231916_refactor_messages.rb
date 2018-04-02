class RefactorMessages < ActiveRecord::Migration[5.1]
  def change
    reversible do |dir|
      dir.up {
        change_column :messages, :message, 'VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_bin'
      }
    end
  end
end
