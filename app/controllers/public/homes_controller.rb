class Public::HomesController < ApplicationController

  def top
    # 日程で絞り込み
    # if params[:today_recruit]
    #   recruits = Recruit.where(date: Date.today)
    #   @recruits = recruits.page(params[:page])
    # elsif params[:date_from] && params[:date_end]
    #   # A..Bは『A〜B』として使える
    #   date_from = params[:date_from].to_date
    #   date_end = params[:date_end].to_date
    #   recruits = Recruit.where(date: date_from..date_end)
    #   @recruits = recruits.page(params[:page])

    # else
    #   recruits = Recruit.all
    #   @recruits = recruits.page(params[:page])
    # end

    # 練習形式で絞り込み
    # if params[:practice_type] == 1
    #   recruits = Recruit.where(practice_type: 1)
    #   @recruits = recruits.page(params[:page])
    # elsif params[:practice_type] == 2
    #   recruits = Recruit.where(practice_type: 2)
    #   @recruits = recruits.page(params[:page])
    # else
    #   recruits = Recruit.all
    #   @recruits = recruits.page(params[:page])
    # end

    # ジャンル名で絞り込み
    # if params[:genre_search]
    #   genre = Genre.find_by(name: params[:genre_search])
    #   users = User.where(genre_id: genre.id)
    #   recruits = Recruit.where(user_id: [users.ids])
    #   @recruits = recruits.page(params[:page])

    # else
    #   recruits = Recruit.all
    #   @recruits = recruits.page(params[:page])
    # end

    # お気に入りで絞り込み
    # if params[:liked_posts]==true
    # Recruitに紐づいたLikeのユーザー（いいねした人）が現在のユーザーと同じものを抽出
    # recruits = Recruit.includes(:likes).where(user_id: current_user.id)

    # recruits = Recruit.likes.where(user_id: current_user.id)
    # @recruits = recruits.page(params[:page])




    # ランサックで記述
    @q = Recruit.ransack(params[:q])
    @recruits = @q.result(distinct: true)


    # 募集記事の練習日超えたら非公開に設定
    @recruits.each do |recruit|
      @user = User.find(recruit.user_id)
      if recruit.date.before? Date.today
        recruit.update(open_status: false)
      elsif recruit.user.active_status == false
        recruit.update(open_status: false)
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
end
