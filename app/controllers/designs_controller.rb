class DesignsController < ApplicationController
  def index
  end
  
  def new
    @design = Design.new
  end
  
  def create
    @design = Design.new(design_params)
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
     params.require(:design).permit(:title, :image, :type, :machine)
    end
end
