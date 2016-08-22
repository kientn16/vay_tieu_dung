class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :path
      t.integer :id_item
      t.integer :type

      t.timestamps null: false
    end
  end
end
