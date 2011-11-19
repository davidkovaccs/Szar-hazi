class StocksController < ApplicationController
  before_filter :authenticate_user!
  def index
    @stocks = Stock.all
  end

  def show
    @stock = Stock.find(params[:id])
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(params[:stock])
    if @stock.save
      redirect_to @stock, :notice => "Successfully created stock."
    else
      render :action => 'new'
    end
  end

  def edit
    @stock = Stock.find(params[:id])
  end

  def update
    @stock = Stock.find(params[:id])
    if @stock.update_attributes(params[:stock])
      redirect_to @stock, :notice  => "Successfully updated stock."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @stock = Stock.find(params[:id])
    @stock.destroy
    redirect_to stocks_url, :notice => "Successfully destroyed stock."
  end
end
