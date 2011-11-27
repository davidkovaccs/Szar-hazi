class Ability
  include CanCan::Ability
  
  def initialize(user)
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :broker
      can :manage, :all
    elsif user.role? :user
      can [:index, :show, :update, :edit], Account do |account|
        account.try(:user) == user
      end
      can [:new, :create], Account do |stockVol|
        true
      end

      can [:index, :show, :update, :edit], Order do |order|
        order.account.try(:user) == user
      end
      can [:new, :create], Order do |order|
        true
      end
      can [:destroy], Order do |order|
        order.account.try(:user) == user
      end
     
      can [:index, :show], Transaction do |transaction|
        transaction.orders.first.account.try(:user) == user
      end

      can [:index, :show], StockVol do |stockVol|
        stockVol.account.try(:user) == user
      end

      can [:index, :show], Stock do |stockVol|
        true
      end
    end
  
  end
end
