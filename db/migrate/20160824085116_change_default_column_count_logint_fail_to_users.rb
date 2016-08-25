class ChangeDefaultColumnCountLogintFailToUsers < ActiveRecord::Migration
  def change
    change_column :users, :count_login_fail, :integer, :default => 0
  end
end
