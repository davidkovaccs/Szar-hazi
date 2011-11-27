class CreateStockVols < ActiveRecord::Migration
  def self.up
    create_table :stock_vols do |t|
      t.integer :account_id
      t.integer :volume
      t.integer :stock_id
      t.timestamps
    end
  end

  def self.down
    drop_table :stock_vols
  end
end
