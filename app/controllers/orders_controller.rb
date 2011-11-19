class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(params[:order])

    if @order.buy? and params[:order][:price].to_i > @order.account.balance
      render :action => 'new', :alert => "Nincs eleg penz a szamlan"
      return
    end

    ord = Order.find(:first, :conditions => ["stock_id = ? and price = ? and sell != ?", @order.stock_id, @order.price, @order.sell])
    if @order.save
      if ord
        Rails.logger.info "ASDFASDFASDFASDF"
        trans = Transaction.new
        trans.save
        ord.transaction_id = trans.id
        @order.transaction_id = trans.id
        ord.save
        @order.save
      end
      redirect_to @order, :notice => "Successfully created order."
    else
      render :action => 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      redirect_to @order, :notice  => "Successfully updated order."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to orders_url, :notice => "Successfully destroyed order."
  end
end
