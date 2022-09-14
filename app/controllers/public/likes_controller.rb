class Public::LikesController < ApplicationController
  
  def create
    like = Like.new(like_params)
    like.user_id = current_user.id
    like.save
    recruit = Recruit.find(like.recruit_id)
    redirect_to show_recruits_path(recruit)
  end

  def destroy
    @like = Like.find(params[:id])
    recruit = Recruit.find(like.recruit_id)
    like = current_user.likes.find_by(recruit_id: recruit.id)
    like.destroy
    redirect_to show_recruits_path(recruit)
  end
  
  private
  
  def like_params
    params.require(:like).permit(:user_id, :require_id)
  end
  
  
  
  
  
end
