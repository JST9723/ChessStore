class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.active.alphabetical.paginate(:page => params[:page]).per_page(7)
    @inactive_users = User.inactive.alphabetical.paginate(:page => params[:page]).per_page(7)
  end

  def employees
    @employees = User.employees.alphabetical.paginate(:page => params[:page]).per_page(7)
  end

  def customers
    @customers = User.customers.alphabetical.paginate(:page => params[:page]).per_page(7)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def order_history
    @unshipped_orders = current_user.orders & Order.not_shipped
    @orders = current_user.orders
  end

  def create
    @user = User.new(user_params)
    if @user.save
      if logged_in?
        flash[:notice] = "#{@user.proper_name} is created."
        redirect_to users_path
      else
        session[:user_id] = @user.id
        session[:cart] = Hash.new
        redirect_to home_path, notice: "Thank you for signing up!"
      end
    else
      flash[:error] = "This user could not be created."
      render action: 'new'
    end
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = "#{@user.proper_name} is updated."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end


  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :phone, :username, :password, :password_confirmation, :role, :active)
    end
end
