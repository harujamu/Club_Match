# frozen_string_literal: true

class Public::FollowsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    follow = Follow.new(follower_id: current_user.id, user_id: user.id)
    follow.save
    # フォロー通知メソッド追加
    user.create_notification_follow(current_user, follow)
    redirect_to user_path(user.id)
  end

  def destroy
    user = User.find(params[:user_id])
    follow = Follow.find_by(follower_id: current_user.id, user_id: user.id)
    follow.destroy
    redirect_to user_path(user.id)
  end


  private
    def follow_params
      params.require(:follow).permit(
        :user_id,
        :follower_id
      )
    end

    def user_params
      params.require(:user).permit(
        :club_name,
        :captain_last_name,
        :captain_first_name,
        :age_group,
        :genre_id,
        :prefecture,
        :municipality,
        :address,
        :introduction,
        :image,
        :email,
        :active_status
      )
    end
end
