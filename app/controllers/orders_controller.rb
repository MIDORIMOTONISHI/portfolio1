class OrdersController < ApplicationController
   
  def new
    @order = Order.new
    @user = User.find(current_user.id)
    @design = Design.find(params[:design_id])
    @designer = User.find(@design.user_id)
  end
   
  def create
    @user = User.find(current_user.id)
    @design = Design.find(params[:design_id])
    @designer = User.find(@design.user_id)
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
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
  private
  
    def order_params
      params.require(:order).permit(:size, :hw, :paper, :number, :delivery_date, :note, :order_status)
    end
end
