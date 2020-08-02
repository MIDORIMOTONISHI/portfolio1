class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(design_id: params[:design_id])
    redirect_back(fallback_location: designs_path)
  end

  def destroy
    @like = Like.find_by(design_id: params[:design_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: designs_path)
  end
end
