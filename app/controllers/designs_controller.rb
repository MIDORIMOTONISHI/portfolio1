class DesignsController < ApplicationController
  before_action :set_current_user, only: [:create]
  
  def index
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
  end
  
  def edit
  end
  
  def update
  end
  
  def delete
  end
  
  
  private
  
    def design_params
     params.require(:design).permit(:title, :image, :type, :machine, :user_id)
    end
end
