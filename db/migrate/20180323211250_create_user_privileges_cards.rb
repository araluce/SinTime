class CreateUserPrivilegesCards < ActiveRecord::Migration[5.1]
  def change
    create_table :user_privileges_cards do |t|
      t.belongs_to :privileges_card
      t.belongs_to :user
      t.boolean :active
      t.timestamps
    end

    add_reference :banking_movements, :user_privileges_card, after: :exercise_id
    add_column :privileges_cards, :active, :boolean, after: :identifier, default: true
  end
end
