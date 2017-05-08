class HomeController < ApplicationController
  include ChessStoreHelpers::Cart
  def home
    @items_to_reorder = Item.need_reorder.alphabetical.to_a
    @unshipped_orders = Order.not_shipped.chronological.to_a
  end

  def about
  end

  def contact
  end

  def privacy
  end

end
