class TransactionsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @transactions = Transaction.all
  end

  def show
    @transaction = Transaction.find(params[:id])
  end

  def list
    @transactions = Transaction.all
    @user = User.find(params[:id])
  end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(params[:transaction])
    if @transaction.save
      redirect_to @transaction, :notice => "Successfully created transaction."
    else
      render :action => 'new'
    end
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update_attributes(params[:transaction])
      redirect_to @transaction, :notice  => "Successfully updated transaction."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id])
    @transaction.destroy
    redirect_to transactions_url, :notice => "Successfully destroyed transaction."
  end
end
