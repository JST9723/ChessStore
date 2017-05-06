Rails.application.routes.draw do

  # Routes for main resources
  resources :items
  resources :purchases
  resources :item_prices

  # Semi-static page routes
  get 'home' => 'home#home', as: :home
  get 'about' => 'home#about', as: :about
  get 'contact' => 'home#contact', as: :contact
  get 'privacy' => 'home#privacy', as: :privacy

  # Set the root url
  root :to => 'home#home'

  resources :users
  resources :sessions
  get 'user/edit' => 'users#edit', :as => :edit_current_user
  get 'order/cart' => 'order#get_list_of_items_in_cart', :as => :get_items_in_cart
  get 'signup' => 'users#new', :as => :signup
  get 'login' => 'sessions#new', :as => :login
  get 'logout' => 'sessions#destroy', :as => :logout
  get 'add_to_cart/:id' => 'sessions#add_to_cart', :as => :add_to_cart
  get 'remove_from_cart/:id' => 'carts#remove_from_cart', :as => :remove_from_cart
  get 'subtract_from_cart/:id' => 'carts#subtract_from_cart', :as => :subtract_from_cart
  get 'update_add_to_cart/:id' => 'carts#update_add_to_cart', :as => :update_add_to_cart
  get 'cart_items' => 'carts#cart_items', :as => :cart_items
end
