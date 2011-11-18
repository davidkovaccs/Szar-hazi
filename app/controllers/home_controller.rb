class HomeController < ApplicationController
  def index
  end

  def show_accounts
  end

  def show_orders
  end

  def new_order
    @order = Order.new
  end
end
