class StockVolsController < ApplicationController
  def index
    @stock_vols = StockVol.all
  end

  def show
    @stock_vol = StockVol.find(params[:id])
  end

  def new
    @stock_vol = StockVol.new
  end

  def create
    @stock_vol = StockVol.new(params[:stock_vol])
    if @stock_vol.save
      redirect_to @stock_vol, :notice => "Successfully created stock vol."
    else
      render :action => 'new'
    end
  end

  def edit
    @stock_vol = StockVol.find(params[:id])
  end

  def update
    @stock_vol = StockVol.find(params[:id])
    if @stock_vol.update_attributes(params[:stock_vol])
      redirect_to @stock_vol, :notice  => "Successfully updated stock vol."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @stock_vol = StockVol.find(params[:id])
    @stock_vol.destroy
    redirect_to stock_vols_url, :notice => "Successfully destroyed stock vol."
  end
end
