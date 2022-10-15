class Public::LikesController < ApplicationController
  
  def create
    recruit = Recruit.find(params[:recruit_id])
    like = current_user.likes.new(recruit_id: recruit.id)
    like.save
    # Recruitのliked_statusをtrueにする
    like.recruit.update(liked_status: true)
    # いいね通知メソッド追加
    recruit.create_notification_like(current_user)
    redirect_to root_path
  end

  def destroy
    recruit = Recruit.find(params[:recruit_id])
    like = current_user.likes.find_by(recruit_id: recruit.id)
    like.recruit.update(liked_status: false)
    like.destroy
    redirect_to root_path
  end

  
  private
  
  def like_params
    params.require(:like).permit(:user_id, :recruit_id)
  end
  
  
  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_game, :joint_practice, :detail, :age_group, :recruit_status, :open_status)
  end
  
end