class CreateDonations < ActiveRecord::Migration[5.1]
  def change
    create_table :donations do |t|
      t.belongs_to :sender
      t.belongs_to :receiver
      t.integer :seconds_donated
      t.timestamps
    end
  end
end
