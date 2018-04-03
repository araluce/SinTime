class CreateBetOptions < ActiveRecord::Migration[5.1]
  def change
    create_table :bet_options do |t|

      t.timestamps
    end
  end
end
