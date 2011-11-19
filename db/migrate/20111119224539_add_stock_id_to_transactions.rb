class AddStockIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :stock_id, :integer
  end
end
