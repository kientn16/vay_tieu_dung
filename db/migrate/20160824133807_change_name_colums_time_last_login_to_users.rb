class ChangeNameColumsTimeLastLoginToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :last_login, :expired_time
  end
end
