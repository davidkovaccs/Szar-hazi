class StockVol < ActiveRecord::Base
  attr_accessible :account_id, :volume, :stock_id
  belongs_to :account
  belongs_to :stock
end
