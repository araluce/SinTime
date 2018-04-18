class AddUsedInCards < ActiveRecord::Migration[5.1]
  def change
    remove_column :user_privileges_cards, :active
    add_column :user_privileges_cards, :active, :boolean, default: true, after: :user_id
  end
end
