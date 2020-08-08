class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :cart, :edit_cart, :update_cart]
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
    @orders = Order.where(order_status: "カートへ", user_id: current_user.id).order(created_at: "ASC").group_by(&:design_id)
  end

  def update_cart
  end
  
  private
  
    def user_params
     params.require(:user).permit(:name, :email, :affiliation, :password, :password_confirmation, :img)
    end
end
