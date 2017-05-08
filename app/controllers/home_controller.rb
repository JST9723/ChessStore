class HomeController < ApplicationController
  include ChessStoreHelpers::Cart

  def home
    @items_to_reorder = Item.need_reorder.alphabetical.to_a
    @unshipped_orders = Order.not_shipped.chronological.to_a
  end

  def ship_order
    respond_to do |format|
    @order_item = OrderItem.find(params[:id])
    @order_item.shipped
    @unshipped_orders = Order.not_shipped.chronological.to_a
    format.html { redirect_to home_path}
    format.js
   end
  end

  def about
  end

  def contact
  end

  def privacy
  end



end
