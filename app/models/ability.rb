class Ability
  include CanCan::Ability
  
  def initialize(user)
    
    if user.role? :admin
      can :manage, :all
    elsif user.role? :broker
      can :manage, :all
    elsif user.role? :user
      can :read, Account do |account|
        account.try(:owner) == user
      end
    end
  
  end
end