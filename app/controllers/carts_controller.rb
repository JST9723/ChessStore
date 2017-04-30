class CartsController < ApplicationController
  def show
    # @cart_items = @cart.get_list_of_items_in_cart
    # @total = @cart.calculate_cart_items_cost.to_f
    @cart_items = current_cart
  end

end
