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
    redirect_to(root_url) unless current_user?(@user) || current_user.admin?
  end
end
