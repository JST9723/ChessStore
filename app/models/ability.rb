class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role? :admin
       can :manage, :all
       can [:create, :edit, :update], :all
       can :read, :all
    elsif user.role? :manager
      can :read, :all
      can [:create, :edit, :update], :User
      can [:create, :edit, :update, :destroy], :Item
      can :create, [:ItemPrice, :Purchase]
    elsif user.role? :shipper
      can :update, User do |current_user|
        user.id == current_user.id
      end
      can :read, :all
    elsif user.role? :customer
      can :read, :Item
      can :update, User do |current_user|
        user.id == current_user.id
      end
     else
       can :create, :User
       can :create, :session
       can :read, :Item
     end
  end
end
