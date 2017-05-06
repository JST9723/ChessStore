class OrderItemsController < ApplicationController
  include ChessStoreHelpers::Cart

  def new
    @order_item = OrderItem.new
  end



end
