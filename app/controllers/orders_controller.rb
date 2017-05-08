class OrdersController < ApplicationController
  include ChessStoreHelpers::Cart
  include ChessStoreHelpers::Shipping

  before_action :check_login
  before_action :set_order, only: [:show,:edit, :update,:destroy]
  authorize_resource

  def index
    @orders = Order.chronological
  end

  def show
    @order_items = @order.order_items
  end

  def new
    @order_items = get_list_of_items_in_cart
    @shipping_costs = calculate_cart_shipping
    @grand_total= calculate_cart_items_cost + @shipping_costs
    @order = Order.new
  end

  def edit
  end

  def create
    @order_items = get_list_of_items_in_cart
    @order = Order.new(order_params)
    @order.date = Date.current
    @order.user_id = current_user.id
    save_each_item_in_cart(@order)
    if @order.save
      save_each_item_in_cart(@order)
      @order.grand_total = calculate_cart_items_cost + @order.shipping_costs
      @order.pay
      @order.save!
      redirect_to order_path(@order), notice: "Successfully placing the order!"

    else
      flash[:error] = "This order could not be created."
      render action: 'new'
    end
  end

  def update
    if @order.update_attributes(order_params)
      flash[:notice] = "This order is updated."
      redirect_to @order
    else
      flash[:error] = "This order could not be updated."
      render :action => 'edit'
    end
  end

  def destroy
    @order.destroy
    if can? :edit, Order
      redirect_to orders_path, notice: "Successfully removed this order from the system."
    else
      redirect_to order_history_path, notice: "Successfully removed this order from the system."
    end
  end


  private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
      params.require(:order).permit(:school_id, :user_id, :date, :grand_total,:expiration_year,:credit_card_number,:expiration_month, :payment_receipt)
  end


end
