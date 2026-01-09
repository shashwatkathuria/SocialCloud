class AddDefaultToAdminInUsers < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users, :admin, false
  end
end
