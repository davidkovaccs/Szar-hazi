class CreateStocks < ActiveRecord::Migration
  def self.up
    create_table :stocks do |t|
      t.string :name
      t.integer :price
      t.timestamps
    end
  end

  def self.down
    drop_table :stocks
  end
end
