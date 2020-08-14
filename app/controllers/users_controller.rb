class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :cart, :update_cart]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]
  
  def index
    @designers = User.where(position: "デザイナー")
    @customers = User.where(position: "カスタマー").paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "新規登録しました。"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:danger] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
  
  
    # 注文カート
  def cart
    @orders = Order.where(order_status: "カートへ", user_id: current_user.id).order(created_at: "ASC")
  end

  def update_cart
    ActiveRecord::Base.transaction do
      cart_params.each do |id, item|
        order = Order.find(id)
        order.update_attributes!(item)
      end
    end
    flash[:success] = "カートの内容を発注しました。"
    redirect_to designs_url
  rescue ActiveRecord::RecordInvalid # トランザクション
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to  cart_user_url(@user)
  end
  
  
    #発注確認
  def order_consent
    @orders = Order.where(order_status: "発注").order(created_at: "ASC").group_by(&:user_id)
    @user = User.find(current_user.id)
  end
  
  def update_order_consent
    @user = User.find(current_user.id)
    ActiveRecord::Base.transaction do
      consent_params.each do |id, item|
        if item[:receipt] == "true"
          order = Order.find(id)
          order.update_attributes!(item)
          flash[:success] = "受注しました。"
        else
          flash[:danger] = "未受注の発注があります。"
        end
      end
    end
    redirect_to order_consent_user_url(@user)
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to order_consent_user_url
  end
  
  
    #発送確認  
  def order_sending
    @user = User.find(current_user.id)
    @orders = Order.where(order_status: "受注").where(designer_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
  end

  def update_order_sending
    @user = User.find(current_user.id)
    ActiveRecord::Base.transaction do
      sending_params.each do |id, item|
        if item[:sending] == "true"
          order = Order.find(id)
          order.update_attributes!(item)
          flash[:success] = "発送しました。"
        else
          flash[:danger] = "未発送の発注があります。"
        end
      end
    end
    redirect_to order_sending_user_url(@user)
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to order_sending_user_url(@user)
  end
  
  
    #納品確認  
  def order_receiving
    @orders = Order.where(order_status: "発送済").where(user_id: current_user.id).order(created_at: "ASC").group_by(&:user_id)
    @user = User.find(current_user.id)
  end

  def update_order_receiving
    @user = User.find(current_user.id)
    ActiveRecord::Base.transaction do
      receiving_params.each do |id, item|
        if item[:receiving] == "true"
          order = Order.find(id)
          order.update_attributes!(item)
          flash[:success] = "納品を確認しました。"
        else
          flash[:danger] = "未納品の発注があります。"
        end
      end
    end
    redirect_to order_receiving_user_url(@user)
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to order_receiving_user_url(@user)
  end
  
  
   # 発注ログ
  def admin_order_log
    @orders = Order.where(order_status: ["受注","発送済","納品済"]).order(created_at: "ASC").group_by(&:user_id)
    @user = User.find(current_user.id)
  end
  
  def designer_order_log
    @user = User.find(current_user.id)
    @orders = Order.where(order_status: ["発送済","納品済"]).where(designer_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
  end
  
  def customer_order_log
    @user = User.find(current_user.id)
    @orders = Order.where(order_status: ["受注","発送済","納品済"]).where(user_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
  end
  
  private
  
    def user_params
     params.require(:user).permit(:position, :name, :email, :affiliation, :password, :password_confirmation, :img)
    end
    
    def cart_params
      params.require(:user).permit(orders: [:order_status, :designer_id])[:orders]
    end
    
    def consent_params
      params.require(:user).permit(orders: [:receipt, :order_status])[:orders]
    end
    
    def sending_params
      params.require(:user).permit(orders: [:sending, :order_status])[:orders]
    end
    
    def receiving_params
      params.require(:user).permit(orders: [:receiving, :order_status])[:orders]
    end
end
