class AddUserStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :status, :integer, null: false, default: 0, after: :remember_created_at
    add_column :users, :logged, :boolean, null: false, default: false, after: :last_sign_in_at
    add_column :users, :name, :string, after: :id
    add_column :users, :lastname, :string, after: :name
    add_column :users, :dni, :string, after: :lastname
    add_column :users, :alias, :string, after: :dni, unique: true

    add_column :users, :tdv, :datetime, null: false, default: Date.today + 15, after: :logged
    add_column :users, :tsc, :datetime, null: false, default: Date.today, after: :tdv
    add_column :users, :tsb, :datetime, null: false, default: Date.today, after: :tsc
    add_column :users, :untouchable, :boolean, null: false, default: false, after: :tsb

    add_index :users, :alias
  end
end
