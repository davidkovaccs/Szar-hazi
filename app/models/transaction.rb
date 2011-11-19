class Transaction < ActiveRecord::Base
  attr_accessible :price, :stock_id, :created_at
  has_many :orders
end

