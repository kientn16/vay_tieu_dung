class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :title
      t.string :description
      t.text :content
      t.integer :status
      t.integer :type

      t.timestamps null: false
    end
  end
end
