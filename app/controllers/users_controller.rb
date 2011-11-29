# encoding: UTF-8
class UsersController < ApplicationController
  load_and_authorize_resource
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    Rails.logger.info "Password: " + @user.first_name
    if @user.update_attribute(:first_name, params[:user][:first_name]) and @user.update_attribute(:last_name, params[:user][:last_name]) and @user.update_attribute(:email, params[:user][:email])
      redirect_to @user, :notice  => "Felhasznalo sikeresen módosítva."
    else
      render :action => 'edit'
    end
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
  
  def touser
    if !current_user.role?(:admin)
      redirect_to @user, :notice => "Nincs jogosultsága módosítani.."
      return
    end
    @user = User.find(params[:id])
      @user.roles = [Role.find_by_name(:user)]
    redirect_to @user, :notice => "Szerepkör módisítva."
  end

  def toadmin
    if !current_user.role?(:admin)
      redirect_to @user, :notice => "Nincs jogosultsága módosítani.."
      return
    end
    @user = User.find(params[:id])
    @user.roles = [Role.find_by_name(:admin)]
    redirect_to @user, :notice => "Szerepkör módisítva."
  end

  def tobroker
    if !current_user.role?(:admin)
      redirect_to @user, :notice => "Nincs jogosultsága módosítani.."
      return
    end
    @user = User.find(params[:id])
    @user.roles = [Role.find_by_name(:broker)]
    @user.save
    redirect_to @user, :notice => "Szerepkör módisítva."
  end
end
