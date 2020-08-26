class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :cart, :update_cart, :order_consent, :update_order_consent,
                                  :order_sending, :update_order_sending, :order_receiving, :update_order_receiving,
                                  :admin_order_log, :designer_order_log, :customer_order_log]
  before_action :logged_in_user, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :cart, :update_cart, :order_sending, :update_order_sending,
                                      :order_sending, :update_order_sending, :order_receiving, :update_order_receiving,
                                      :admin_order_log, :designer_order_log, :customer_order_log]
  before_action :admin_user, only: [:destroy, :index, :order_consent, :update_order_consent, :admin_order_log]
  
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
  end
  
  def update_order_consent
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
    redirect_to designs_url
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to designs_url
  end
  
  
    #発送確認  
  def order_sending
    @orders = Order.where(order_status: "受注").where(designer_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
  end

  def update_order_sending
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
    redirect_to designs_url
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to designs_url
  end
  
  
    #納品確認  
  def order_receiving
    @orders = Order.where.not(order_status: ["カートへ","納品済"]).where(user_id: current_user.id).order(created_at: "ASC").group_by(&:user_id)
  end

  def update_order_receiving
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
    redirect_to designs_url
  rescue ActiveRecord::RecordInvalid
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to designs_url
  end
  
  
   # 発注ログ
  def admin_order_log
    if params[:search].blank?
      @orders = Order.where.not(order_status: "カートへ").order(created_at: "ASC").group_by(&:user_id)
    else
      select_day = params[:search]["created_at(1i)"] + "-" + format("%02d", params[:search]["created_at(2i)"]) + "-" + format("%02d", params[:search]["created_at(3i)"])
      first_day = select_day.to_date.beginning_of_month
      last_day = first_day.end_of_month
      @orders = Order.where(created_at: first_day..last_day).where.not(order_status: "カートへ").order(created_at: "ASC").group_by(&:user_id)
      if @orders.count == 0
        flash.now[:danger] = "発注履歴はありません。"
      end
    end
  end
  
  def designer_order_log
    if params[:search].blank?
      @orders = Order.where(order_status: ["発送済","納品済"]).where(designer_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
    else
      select_day = params[:search]["created_at(1i)"] + "-" + format("%02d", params[:search]["created_at(2i)"]) + "-" + format("%02d", params[:search]["created_at(3i)"])
      first_day = select_day.to_date.beginning_of_month
      last_day = first_day.end_of_month
      @orders = Order.where(created_at: first_day..last_day).where(order_status: ["発送済","納品済"]).where(designer_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
      if @orders.count == 0
        flash.now[:danger] = "発送履歴はありません。"
      end
    end
  end
  
  def customer_order_log
    if params[:search].blank?
      @orders = Order.where.not(order_status: "カートへ").where(user_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
    else
      select_day = params[:search]["created_at(1i)"] + "-" + format("%02d", params[:search]["created_at(2i)"]) + "-" + format("%02d", params[:search]["created_at(3i)"])
      first_day = select_day.to_date.beginning_of_month
      last_day = first_day.end_of_month
      @orders = Order.where(created_at: first_day..last_day).where.not(order_status: "カートへ").where(user_id: @user.id).order(created_at: "ASC").group_by(&:user_id)
      if @orders.count == 0
        flash.now[:danger] = "発注履歴はありません。"
      end
    end
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
