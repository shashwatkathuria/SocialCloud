class AddSerializationForFollowersInUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :followers, :text
  end
end
