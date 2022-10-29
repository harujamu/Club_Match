class Public::HomesController < ApplicationController

  def top
    # ランサックで記述
    @q = Recruit.ransack(params[:q])
    # 同じジャンルの募集情報のみ表示
    if user_signed_in?
      recruits = @q.result(distinct: true).where(open_status: true)
      @recruits = recruits.to_a.select {|r| (r.user.genre_id == current_user.genre.id) }
    else
      @recruits = @q.result(distinct: true).where(open_status: true)
    end
    # ランサックだけではcurrent_userのいいねかどうかの判断ができないので、ランサックで拾ったいいね付き投稿がcurrent_userのものか調べる
    if params.dig(:q, :liked_status_eq) == "true"
      @recruits = @recruits.to_a.select {|r| r.likes.find_by(user_id: current_user) }
    end

  end

  private

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end

  def like_params
    params.require(:like).permit(:user_id, :recruit_id)
  end

  end