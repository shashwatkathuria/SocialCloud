class AddUniquenessToUsernameAndEmailFieldInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :username, :string, unique: true
    change_column :users, :email, :string, unique: true
  end
end
