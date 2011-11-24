class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation,
  :remember_me, :active

  has_many :accounts
  
  has_and_belongs_to_many :roles
  
  def role?(role)
    return !!self.roles.find_by_name(role)
  end
  
  def active_for_authentication? 
    super && active? 
  end 

  def inactive_message 
    if !active? 
      :inactive 
    else 
      super # Use whatever other message 
    end 
  end
end
