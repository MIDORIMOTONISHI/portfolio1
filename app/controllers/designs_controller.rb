class DesignsController < ApplicationController
  before_action :set_current_user, only: [:create]
  before_action :set_design, only: [:show, :destroy, :edit, :update]
  
  def index
    @designs = Design.all
  end
  
  def new
    @design = Design.new
  end
  
  def create
    @design = Design.new(
      title: params[:design][:title],
      image: params[:design][:image],
      type: params[:design][:type],
      machine: params[:design][:machine],
      user_id: @current_user.id
    )
    if @design.save
      flash[:success] = "デザインを投稿しました。"
      redirect_to designs_url
    else
      render :new
    end
  end
  
  def show
    @user = User.find(@design.user_id)
  end
  
  def edit
  end
  
  def update
    if @design.update_attributes(design_params)
      flash[:success] = "デザインを更新しました。"
      redirect_to @design
    else
      render :edit
    end
  end
  
  def destroy
    @design.destroy
    flash[:danger] = "#{@design.title}のデータを削除しました。"
    redirect_to designs_url
  end
  
  
  private
  
    def design_params
     params.require(:design).permit(:title, :image, :type, :machine, :user_id)
    end
    
    def set_design
      @design = Design.find(params[:id])
    end
end
