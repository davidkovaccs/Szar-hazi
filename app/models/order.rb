class Order < ActiveRecord::Base
  attr_accessible :account_id, :stock_id, :price, :sell
  
  belongs_to :account
end
