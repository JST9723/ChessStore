class CartsController < ApplicationController
  include ChessStoreHelpers::Cart

  def cart_items
    @cart = current_cart
    @order_items = get_list_of_items_in_cart

  end

  def show
    # @cart_items = @cart.get_list_of_items_in_cart
    # @total = @cart.calculate_cart_items_cost.to _f
    @cart_items = current_cart
  end

  def remove_from_cart
    remove_item_from_cart(params[:id])
    redirect_to cart_items_path
  end

  def subtract_from_cart
    subtract_item_from_cart(params[:id])
    redirect_to cart_items_path
  end

  def update_add_to_cart
    add_item_to_cart(params[:id])
    redirect_to cart_items_path
  end



end
