class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :fullname
      t.string :address
      t.integer :phone , :limit => 8
      t.string :email
      t.text :content
      t.integer :status

      t.timestamps null: false
    end
  end
end
