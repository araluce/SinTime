class CreateBetOptionUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :bet_option_users do |t|
      t.belongs_to :user
      t.belongs_to :bet_option
      t.integer :time_wagered
      t.timestamps
    end
  end
end
