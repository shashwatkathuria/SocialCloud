class AddFollowersAndFollowingToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :followers, :text
    add_column :users, :following, :text
  end
end
