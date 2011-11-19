class Stock < ActiveRecord::Base
  attr_accessible :name, :price
  
  def price
    p = 0
    i = 0

    Transaction.all.map { |trans|
        order = trans.orders.first
        if !order then
          Rails.logger.info 'Hiba: ' + trans.id.to_s + ', ' + trans.orders.to_s
        end

        if order.stock.id == id then
          Rails.logger.info 'ASDF'
          p += order.price
          i += 1
        end
        if (i >= 5) then break end
    }

    if i != 0 then p /= i else 0 end
  end

  def update_price
  end
end
