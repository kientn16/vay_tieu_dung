class CreateDrawdowns < ActiveRecord::Migration
  def change
    create_table :drawdowns do |t|
      t.integer :sponsor_id
      t.string :contract_date
      t.integer :media_contract_id
      t.string :contract_time
      t.integer :position
      t.integer :media_appoint_id
      t.integer :appoint_in_contact
      t.integer :salary, :limit => 8
      t.integer :media_salary_id
      t.integer :amount
      t.string :amount_time
      t.string :purpose
      t.string :pay_time
      t.string :account_holders
      t.string :account_number
      t.integer :bank_id
      t.integer :branch_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
