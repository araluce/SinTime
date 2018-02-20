class AddUserShareBackpack < ActiveRecord::Migration[5.1]
  def change
    add_reference :twitter_backpacks, :user_share, after: :user_id
  end
end
