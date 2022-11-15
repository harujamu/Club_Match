class Public::HomesController < ApplicationController
  before_action :recruit_ransack_params, only: :top

  def top
    @recruits = @q.result(distinct: true).opened
    # 同じジャンルの募集のみ表示
    if user_signed_in?
      @recruits = @recruits.joins(:user).where("user.genre_id": current_user.genre.id)
      # ランサックだけではcurrent_userのいいねかどうかの判断ができないので、ランサックで拾ったいいね付き投稿がcurrent_userのものか調べる
      @recruits = @recruits.joins(:likes).distinct.where("likes.user_id": current_user.id) if params.dig(:q, :liked_status_eq) == "true"
    end
  end

  private

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end

  def like_params
    params.require(:like).permit(:user_id, :recruit_id)
  end

  def recruit_ransack_params
    # ランサックで記述
    @q = Recruit.ransack(params[:q])
  end
end