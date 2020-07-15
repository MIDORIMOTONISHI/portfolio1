class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  
  def index
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
  end
  
  private
  
    def user_params
     params.require(:user).permit(:name, :email, :affiliation, :password, :password_confirmation)
    end
end
