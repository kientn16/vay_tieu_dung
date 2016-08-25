class AddColumsTimeLastLoginToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_login,:string
  end
end
