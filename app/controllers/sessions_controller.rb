class SessionsController < ApplicationController
   #before_action :check_login, only: [:edit, :update, :destroy]

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
 end
