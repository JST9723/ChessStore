class PurchasesController < ApplicationController
  before_action :check_login
  authorize_resource

  def index
    @purchases = Purchase.chronological.paginate(:page => params[:page]).per_page(10)
  end

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    respond_to do |format|
    if @purchase.save
      format.html { redirect_to @purchase, notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}." }
      @item = @purchase.item
      format.js
    else
      format.html { render action: 'new' }
      format.json { render json: @purchase.errors, status: :unprocessable_entity }
      format.js
    end
  end
  end

  private
  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end

end
