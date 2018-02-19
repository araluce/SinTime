class CreateTweeters < ActiveRecord::Migration[5.1]
  def change
    create_table :tweeters do |t|
      t.string :tweeter, nil: false

      t.timestamps
    end
  end
end
