# encoding: UTF-8
class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def activate
    @user = User.find(params[:id])
    @user.active = 1
    @user.save
    redirect_to '/users', :notice => @user.first_name + " " + @user.last_name + " felhasználó aktiválva."
  end
 
  def deactivate
    @user = User.find(params[:id])
    @user.active = 0
    @user.save
    redirect_to '/users', :notice => @user.first_name + " " + @user.last_name + " felhasználó felfüggesztve."
  end
end
