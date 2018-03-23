class CreatePrivilegesCards < ActiveRecord::Migration[5.1]
  def change
    create_table :privileges_cards do |t|
      t.attachment :card
      t.string :title
      t.text :description
      t.integer :xp_cost
      t.string :identifier
      t.timestamps
    end
  end
end
