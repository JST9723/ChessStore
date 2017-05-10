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
      can [:create, :edit, :update], User
      can [:create, :edit, :update, :destroy], Item
      can :create, Purchase
<<<<<<< HEAD
=======
      can :create, School
>>>>>>> nav
      can [:create, :edit, :update, :destroy], Order
      can [:create, :edit, :update, :destroy], OrderItem
      can :create, [:ItemPrice, :Purchase, :School]
    elsif user.role? :shipper
      can :read, Order
      can :read, Item
      # can :update, User do |current_user|
      #   user.id == current_user.id
      # end
    elsif user.role? :customer
      can :create, Order
      can [:read, :destroy], Order do |o|
        o.user_id == user.id
      end
      can [:create, :destroy, :read], OrderItem
      can :create, School
      can :create, User
      can :read, Item
      # they can read their own profile
      can :show, User do |u|
        u.id == user.id
      end
      # they can update their own profile
      can :update, User do |u|
        u.id == user.id
      end
     else
       can :create, School
       can :create, User
       can :create, :session
       can :read, Item
     end
  end
end
