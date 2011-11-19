class Stock < ActiveRecord::Base
  attr_accessible :name, :price

  def update_price
    self.price = 0
    i = 0
    Rails.logger.info 'PRICE UPDATE FROM:' + self.price.to_s
    Transaction.all.map { |trans|
        order = trans.orders.first
        if !order then
          Rails.logger.info 'Hiba: ' + trans.id.to_s + ', ' + trans.orders.to_s
        end

        if order.stock.id == id then
          Rails.logger.info 'ASDF'
          self.price += order.price
          i += 1
        end
    }

    self.price /= i
    Rails.logger.info 'PRICE UPDATED TO: ' + self.price.to_s

    self.save
  end
end
