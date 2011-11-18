class Account < ActiveRecord::Base
  attr_accessible :user_id, :balance, :name

  belongs_to :user
  has_many :orders
end
