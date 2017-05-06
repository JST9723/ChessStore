class SessionsController < ApplicationController
   #before_action :check_login, only: [:edit, :update, :destroy]

   include ChessStoreHelpers::Cart


   def new
   end

   def create
     user = User.find_by_email(params[:email])
     if user && User.authenticate(params[:email], params[:password])
       session[:user_id] = user.id
       session[:cart] = Hash.new

       # Example of how to add to cart
       # session[:cart] = session[:cart].push(some item object)

       redirect_to home_path, notice: "Logged in!"
     else
       flash.now.alert = "Email or password is invalid"
       render action: 'new'
     end
   end

   def destroy
     session[:user_id] = nil
     session[:cart] = nil
     redirect_to home_path, notice: "Logged out!"
   end

   def add_to_cart
     add_item_to_cart(params[:id])
     redirect_to items_path
   end

   def remove_from_cart
     remove_item_from_cart(params[:id])
     redirect_to cart_items_path
   end

   def cart_items
     @cart = current_cart
     @order_items = get_list_of_items_in_cart

   end

 end
