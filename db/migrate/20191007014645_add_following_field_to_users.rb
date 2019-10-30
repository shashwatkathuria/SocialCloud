class AddFollowingFieldToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :following, :text
  end
end
