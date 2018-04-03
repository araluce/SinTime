class CreateBetOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :bet_options do |t|
      t.belongs_to :bet
      t.string :option
      t.boolean :right_option, default: false
      t.timestamps
    end
  end
end
