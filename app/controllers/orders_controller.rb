class OrdersController < ApplicationController
  before_action :set_order_user, only: [:order_show, :create_order_show, :edit_cart, :update_cart]
  before_action :set_design, only: [:order_show, :create_order_show]
  before_action :designer, only: [:order_show, :create_order_show]
   
  def order_show
    @order = Order.new
  end
   
  def create_order_show
    @order = Order.new(order_params)
    @order.design_id = @design.id
    @order.user_id = @user.id
    if @order.save
      flash[:success] = "発注内容をカートに保存しました。"
      redirect_to designs_url
    else
      render :new
    end
  end
  
  def index
  end
  
  def show
  end
  
  def destroy
  end
  
  def edit_cart
    @orders = Order.where(order_status: "カートへ", user_id: current_user.id).order(created_at: "ASC").group_by(&:design_id)
  end
  
  def update_cart
  
  end
  
  private
  
    def order_params
      params.require(:order).permit(:size, :hw, :paper, :number, :delivery_date, :note, :order_status)
    end
    
    def cart_params
      params.require(:user).permit(orders: [:size, :hw, :paper, :number, :delivery_date, :note, :order_status])[:orders]
    end
    
    def set_order_user
      @user = User.find(current_user.id)
    end
    
    def set_design
      @design = Design.find(params[:design_id])
    end
    
    def designer
      @designer = User.find(@design.user_id)
    end
end
