class CreateTransactions < ActiveRecord::Migration
  def up
    create_table :transactions do |t|
      t.timestamps
    end
  end

  def down
    drop_table :stocks
  end
end
