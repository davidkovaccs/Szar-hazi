class HomeController < ApplicationController
  def index
    if params[:stock] then
      @stock_id = params[:stock]
    else
      @stock_id = 1
    end
  end

  def show_accounts
  end

  def show_orders
  end

  def new_order
    @order = Order.new
  end
end
