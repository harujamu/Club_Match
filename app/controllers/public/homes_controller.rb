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
      # if params[:practice_game] == true && params[:joint_practice]== false
      #   recruits = Recruit.where(practice_game: true, joint_practice: false)
      #   @recruits = recruits.page(params[:page])
      # elsif params[:joint_practice] == true && params[:practice_game] == false
      #   recruits = Recruit.where(practice_game: false, joint_practice: true)
      #   @recruits = recruits.page(params[:page])
      # else
      #   recruits = Recruit.all
      #   @recruits = recruits.page(params[:page])
      # end

      # # ジャンル名で絞り込み
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

        # likes = Like.where(user_id: current_user.id)
        # recruit_ids = likes.pluck(:recruit_id)
        # recruits = recruit_ids.map{|id| Recruit.find(id)}

        # recruit_ids = Like.where(user_id: current_user.id).pluck(:recruit_id)
        # recruit_ids.each do |id|
        #   liked_recruit = Recruit.find(recruit_id: id)
        # end
        # recruits = liked_recruit.all


        # @recruits = recruits.page(params[:page])
      # else
      #   recruits = Recruit.all
      #   @recruits = recruits.page(params[:page])
      # end

    # ランサックで記述
    # recruits = Recruit.all
    # recruits.each do |recruit|
    #   liked_id = recruit.likes.where(user_id: current_user.id)
    # end
    @q = Recruit.ransack(params[:q])
    @recruits = @q.result(distinct: true)


    # 募集記事の練習日超えたら非公開に設定
    @recruits.each do |recruit|
      if recruit.date.before? Date.today
        recruit.update(open_status: false)
      end
    end

    # like = Like.new

    @recruits.each do |recruit|
      @user = User.find(recruit.user_id)
    end

  end

  private

  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_game, :joint_practice, :detail, :age_group, :recruit_status, :open_status)
  end

  def like_params
    params.require(:like).permit(:user_id, :recruit_id)
  end

end
