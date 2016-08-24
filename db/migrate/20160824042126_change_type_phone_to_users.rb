class ChangeTypePhoneToUsers < ActiveRecord::Migration
  def change
    change_column :users, :phone, :string
    change_column :contacts, :phone, :string
  end
end
