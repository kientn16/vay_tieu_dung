class ChangeDefaultColumToUsers < ActiveRecord::Migration
  def change
    change_column :users, :change_email, :integer, :default => 1
  end
end
