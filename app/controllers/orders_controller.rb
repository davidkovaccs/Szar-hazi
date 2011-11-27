# encoding: UTF-8
class OrdersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    if current_user.accounts.empty? then
#      flash[:alert] = "Nincs még számlája, hozzon létre egyet, hogy megbízást tudjon kötni."
      flash[:alert] = "nn"
      redirect_to :controller => "accounts", :action => 'new'
      return
    end

    @orders = Order.all
  end

  def list
    @orders = Order.all
    @user = User.find(params[:id])
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

  def check_transaction
    Rails.logger.info "buy: " + @order.buy?.to_s
    if !@order.buy? and @order.account.stock_vols.find_by_stock_id(@order.stock_id).nil?
      flash[:alert] = "Nincs ilyen tőzsdei papír a '" + @order.account.name + "' számlán."
      return false
    end
    
    if @order.buy? and params[:order][:price].to_i > @order.account.balance
      flash[:alert] = "Nincs elég pénz a '" + @order.account.name + "' számlán."
      return false
    end
    ord = Order.find(:first, :conditions => ["stock_id = ? and price = ? and sell != ? and user_id <> ?", @order.stock_id, @order.price, @order.sell, @order.account.user.id])
    
    
    if @order.save
      if @order.buy?
        @order.update_account
      end

      # ugylet letrehozasa
      if ord
        Rails.logger.info "ASDFASDFASDFASDF"
        trans = Transaction.new
        trans.price = ord.price
        trans.stock_id = @order.stock_id
        trans.save
        ord.transaction_id = trans.id
        @order.transaction_id = trans.id
        ord.save
        @order.save

        stockVol = ord.account.stock_vols.find_by_stock_id(ord.stock_id)
        if stockVol.nil?
          stockVol = StockVol.new
          stockVol.volume = 0
          stockVol.account_id = ord.account_id
          stockVol.stock_id = ord.stock_id
        end

        if (ord.buy?)
          Rails.logger.info "Ord0: " + ord.sell.to_s
          stockVol.volume += 1
        else
          Rails.logger.info "Ord1: " + ord.sell.to_s
          stockVol.volume -= 1
        end
        stockVol.save

        stockVol2 = @order.account.stock_vols.find_by_stock_id(@order.stock_id)
        if stockVol2.nil?
          stockVol2 = StockVol.new
          stockVol2.volume = 0
          stockVol2.account_id = @order.account_id
          stockVol2.stock_id = @order.stock_id
        end

        if (@order.buy?)
          Rails.logger.info "Ord0: " + @order.sell.to_s
          stockVol2.volume += 1
        else
          Rails.logger.info "Ord1: " + @order.sell.to_s
          stockVol2.volume -= 1
        end
        stockVol2.save

        if @order.buy?
          ord.update_account
        else
          @order.update_account
        end
        @order.stock.update_price
      end
      return true
    else
      return false
    end

    return true
  end

  def create
    @order = Order.new(params[:order])
    
    @order.user_id = current_user.id;

    if (check_transaction)
      redirect_to @order, :notice => "Megbízás sikeresen létrehozva."
    else
      redirect_to :action => 'new'
    end
  end

  def edit
    @order = Order.find(params[:id])
    if !@order.transaction_id.nil?
       redirect_to :controller => "orders", :action => 'index'
    end
  end

  def update
    @order = Order.find(params[:id])
    @order.attributes = params[:order]

    if check_transaction
      redirect_to @order, :notice  => "Megbízás sikeresen módosítva."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.transaction
      flash[:alert] = "Olyan ügyletet nem tudsz törölni amiből már létrejött egy tranzakció."
      render :action => 'index'
      return
    end
    if @order.buy?
      @order.account.balance += @order.price
      @order.account.save
    end
    @order.destroy
    redirect_to orders_url, :notice => "Megbízás sikeresen törölve."
  end
end
