class CreateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :districts do |t|
      t.string :name, null: false, unique: true
      t.timestamps
    end

    add_reference :users, :district, after: :alias, optional: true
  end
end
