class ItemsController < ApplicationController
  before_action :check_login, only: [:edit, :create, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    # get info on active items for the big three...
    @boards = Item.active.for_category('boards').alphabetical.paginate(:page => params[:page]).per_page(10)
    @pieces = Item.active.for_category('pieces').alphabetical.paginate(:page => params[:page]).per_page(10)
    @clocks = Item.active.for_category('clocks').alphabetical.paginate(:page => params[:page]).per_page(10)
    @supplies = Item.active.for_category('supplies').alphabetical.paginate(:page => params[:page]).per_page(10)
    # get a list of any inactive items for sidebar
    @inactive_items = Item.inactive.alphabetical.to_a
    # get items by color
    @red_items = Item.active.for_color('red').alphabetical
    @black_items = Item.active.for_color('black').alphabetical
    @green_items = Item.active.for_color('green').alphabetical
    @brown_items = Item.active.for_color('brown').alphabetical
    @beige_items = Item.active.for_color('beige').alphabetical
  end

  def red_items
    @red_items = Item.active.for_color('red').alphabetical
    @black_items = Item.active.for_color('black').alphabetical
    @green_items = Item.active.for_color('green').alphabetical
    @brown_items = Item.active.for_color('brown').alphabetical
    @beige_items = Item.active.for_color('beige').alphabetical

  end

  def black_items
    @red_items = Item.active.for_color('red').alphabetical
    @black_items = Item.active.for_color('black').alphabetical
    @green_items = Item.active.for_color('green').alphabetical
    @brown_items = Item.active.for_color('brown').alphabetical
    @beige_items = Item.active.for_color('beige').alphabetical

  end

  def green_items
    @red_items = Item.active.for_color('red').alphabetical
    @black_items = Item.active.for_color('black').alphabetical
    @green_items = Item.active.for_color('green').alphabetical
    @brown_items = Item.active.for_color('brown').alphabetical
    @beige_items = Item.active.for_color('beige').alphabetical
  end

  def brown_items
    @red_items = Item.active.for_color('red').alphabetical
    @black_items = Item.active.for_color('black').alphabetical
    @green_items = Item.active.for_color('green').alphabetical
    @brown_items = Item.active.for_color('brown').alphabetical
    @beige_items = Item.active.for_color('beige').alphabetical
  end

  def show
    # get the price history for this item
    @price_history = @item.item_prices.chronological.to_a
    # everyone sees similar items in the sidebar
    @similar_items = Item.for_category(@item.category).active.alphabetical.to_a - [@item]
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to item_path(@item), notice: "Successfully created #{@item.name}."
    else
      render action: 'new'
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item), notice: "Successfully updated #{@item.name}."
    else
      render action: 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: "Successfully removed #{@item.name} from the system."
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :color, :category, :picture, :weight, :inventory_level, :reorder_level, :active)
  end

end
