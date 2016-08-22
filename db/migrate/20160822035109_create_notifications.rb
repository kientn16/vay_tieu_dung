class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.string :content
      t.integer :is_read
      t.integer :type

      t.timestamps null: false
    end
  end
end
