class Public::LikesController < ApplicationController
  
  def create
    like = Like.new(like_params)
    like.user_id = current_user.id
    like.recruit_id = recruit.id
    like.save
    redirect_to recruits_path
  end

  def destroy
    like = likes.find_by(recruit_id: recruit.id)
    like.user_id = current_user.id
    like.destroy
    redirect_to recruits_path
  end
  
  private
  
  def like_params
    params.require(:like).permit(:user_id, :recruit_id)
  end
  
  
  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end
  
end
