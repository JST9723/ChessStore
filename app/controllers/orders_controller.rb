class OrdersController < ApplicationController
  include ChessStoreHelpers::Cart

  before_action :check_login

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def edit
  end


end
