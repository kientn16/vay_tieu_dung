class ChangeColumnsToUsers < ActiveRecord::Migration
  def change
    change_column :users, :by_social, :integer, :default => 0
    add_column :users, :marriage, :integer, :default => 0
  end
end
