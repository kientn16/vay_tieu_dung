class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.references :contract, index: true, foreign_key: true
      t.integer :status_contract
      t.string :created_at
      t.integer :summery, :limit => 8
      t.integer :orgin_rate, :limit => 8
      t.integer :interest_rate, :limit => 8

      t.timestamps null: false
    end
  end
end
