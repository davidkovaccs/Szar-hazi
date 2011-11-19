class Transaction < ActiveRecord::Base
  has_many :orders
end

