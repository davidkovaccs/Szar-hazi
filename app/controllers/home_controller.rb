# encoding: UTF-8
class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
    if params[:stock] then
      @stock_id = params[:stock]
    else
      @stock_id = 1
    end
  end

  def buy
    if current_user.accounts.empty? then
      flash[:alert] = "Nincs még számlája, hozzon létre egyet, hogy megbízást tudjon kötni."
      redirect_to :controller => "accounts", :action => 'new'
      return
    end

    if current_user.accounts.find_by_active(1)
      selected = current_user.accounts.find_by_active(1).id
    else
      selected = current_user.accounts.first.id
    end

    Order.create(  :account_id => selected,
      :stock_id => params[:stock_id],
      :price => Stock.find(params[:stock_id]).price,
      :sell => 0)

    redirect_to :controller => 'orders', :action => 'index'
  end

  def sell
    if current_user.accounts.empty? then
      flash[:alert] = "Nincs még számlája, hozzon létre egyet, hogy megbízást tudjon kötni."
      redirect_to :controller => "accounts", :action => 'new'
      return
    end

    if current_user.accounts.find_by_active(1)
      selected = current_user.accounts.find_by_active(1).id
    else
      selected = current_user.accounts.first.id
    end

    Order.create(  :account_id => selected,
      :stock_id => params[:stock_id],
      :price => Stock.find(params[:stock_id]).price,
      :sell => 1)

    redirect_to :controller => 'orders', :action => 'index'
  end
end
