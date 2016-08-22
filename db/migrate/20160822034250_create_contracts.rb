class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :code
      t.string :value
      t.string :deadline
      t.integer :status
      t.integer :paid, :limit => 8
      t.integer :penance, :limit => 8
      t.integer :debt, :limit => 8
      t.integer :drawdowns_id
      t.string :loans_time
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
