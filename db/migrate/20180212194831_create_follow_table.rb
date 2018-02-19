class CreateFollowTable < ActiveRecord::Migration[5.1]
  def change
    create_table :tweeters_users do |t|
      t.references :user
      t.references :tweeter
    end
  end
end
