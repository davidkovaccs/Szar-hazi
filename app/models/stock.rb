class Stock < ActiveRecord::Base
  attr_accessible :name, :price

  def update_price
    @price = 0
    Transaction.all.map { |trans| if trans.orders.first.stock_id == id then @price += trans.orders.first.price end }
    save
  end
end
