class CreateUserRuntastics < ActiveRecord::Migration[5.1]
  def change
    create_table :user_runtastics do |t|
      t.references :user
      t.string :name
      t.integer :runtastic_id
      t.string :email
      t.string :password
      t.integer :age
      t.boolean :alexa_integration
      t.timestamps
    end
  end
end
