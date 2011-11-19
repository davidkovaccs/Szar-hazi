class Order < ActiveRecord::Base
  attr_accessible :account_id, :stock_id, :price, :sell, :transaction_id
  
  belongs_to :account
  belongs_to :stock
  belongs_to :transaction

  def print_type
      if buy? then
        "Vétel"
      else
        "Eladás"
      end
  end

  def buy?
    !@sell
  end

  def update_account
      if buy?
        account.balance -= price
      else
        account.balance += price
      end

      account.save
  end
end
