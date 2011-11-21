# encoding: UTF-8
class AccountsController < ApplicationController
  before_filter :authenticate_user!
  def index
    @accounts = Account.all
  end

  def list
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new
    @account.user_id = current_user.id
  end

  def create
    @account = Account.new(params[:account])
    @account.user_id = current_user.id
    if @account.save
      redirect_to @account, :notice => "Successfully created account."
    else
      render :action => 'new'
    end
  end

  def edit
    @account = Account.find(params[:id])
  end

  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      redirect_to @account, :notice  => "Successfully updated account."
    else
      render :action => 'edit'
    end
  end

  def activate
    acc = current_user.accounts.find_by_active(1)
    if (acc)
      acc.active = 0
      acc.save
    end
    @account = Account.find(params[:id])
    @account.active = 1
    @account.save
    redirect_to '/show_accounts', :notice => "Account " + @account.name + " is activated"
  end

  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to accounts_url, :notice => "Successfully destroyed account."
  end
end
