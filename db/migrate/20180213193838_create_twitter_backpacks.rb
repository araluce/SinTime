class CreateTwitterBackpacks < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_backpacks do |t|
      t.references :user
      t.references :tweet
      t.integer :backpack_type, default: 0

      t.timestamps
    end
  end
end
