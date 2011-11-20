class OrdersController < ApplicationController
  before_filter :authenticate_user!
  def index
    if current_user.accounts.empty? then
#      flash[:alert] = "Nincs még számlája, hozzon létre egyet, hogy megbízást tudjon kötni."
      flash[:alert] = "nn"
      redirect_to :controller => "accounts", :action => 'new'
      return
    end

    @orders = Order.all
  end

  def show
    if current_user.accounts.empty? then
#       flash[:alert] = "Nincs még számlája, hozzon létre egyet, hogy megbízást tudjon kötni."
      flash[:alert] = "nn"
      redirect_to :controller => "accounts", :action => 'new'
      return
    end
    @order = Order.find(params[:id])
  end

  def new
    if current_user.accounts.empty? then
#       flash[:alert] = "Nincs még számlája, hozzon létre egyet, hogy megbízást tudjon kötni."
      flash[:alert] = "nn"
      redirect_to :controller => "accounts", :action => 'new'
      return
    end

    @order = Order.new
  end
  
  def check_for_account
    
  end

  def create
    @order = Order.new(params[:order])

    if @order.buy? and params[:order][:price].to_i > @order.account.balance
      flash[:alert] = "Nincs eleg penz a '" + @order.account.name + "' szamlan"
      redirect_to :action => 'new'
      return
    end

    ord = Order.find(:first, :conditions => ["stock_id = ? and price = ? and sell != ?", @order.stock_id, @order.price, @order.sell])
    if @order.save
      if @order.buy?
        @order.update_account
      end

      # ugylet letrehozasa
      if ord
        Rails.logger.info "ASDFASDFASDFASDF"
        trans = Transaction.new
        trans.price = @order.price
        trans.stock_id = @order.stock_id
        trans.save
        ord.transaction_id = trans.id
        @order.transaction_id = trans.id
        ord.save
        @order.save

        if @order.buy?
          ord.update_account
        else
          @order.update_account
        end
        @order.stock.update_price
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
