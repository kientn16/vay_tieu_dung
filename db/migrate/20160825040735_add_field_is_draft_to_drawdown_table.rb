class AddFieldIsDraftToDrawdownTable < ActiveRecord::Migration
  def change
  	add_column :drawdowns, :is_draft, :integer, :default => 0
  end
end
