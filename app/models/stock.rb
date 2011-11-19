class Stock < ActiveRecord::Base
  attr_accessible :name, :price
  
  def price
    p = 0
    i = 0

    Transaction.find(:all, :order => 'created_at DESC').map { |trans|
        if (trans.stock_id != id) then next end
        p += trans.price
        i += 1

        if (i >= 5) then break end
    }

    if i != 0 then p /= i else 0 end
  end

  def update_price
  end
end
