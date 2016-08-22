class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :active_code
      t.integer :status
      t.integer :count_login_fail
      t.string :birthday
      t.integer :by_social
      t.string :facebook_id
      t.string :google_id
      t.integer :change_email
      t.string :passport
      t.integer :media_id
      t.integer :gender
      t.integer :phone, :limit => 8
      t.string :address
      t.integer :provined_id
      t.integer :district_id
      t.integer :ward_id
      t.string :storage_time

      t.timestamps null: false
    end
  end
end
