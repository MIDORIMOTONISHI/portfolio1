class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインして下さい。"
      redirect_to login_url
    end
  end
  
  def correct_user
    unless current_user?(@user) || current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to(root_url)
    end
  end
  
  def admin_user
    unless current_user.admin?
      flash[:danger] = "権限がありません。"
      redirect_to(root_url)
    end
  end
  
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
