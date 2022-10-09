class Public::HomesController < ApplicationController
  
  def top
    if params[:today_recruit]
      recruits = Recruit.where(date: Date.today)
      @recruits = recruits.page(params[:page])
    elsif params[:date_from] && params[:date_end]
      # A..Bは『A〜B』として使える
      date_from = params[:date_from].to_date
      date_end = params[:date_end].to_date
      recruits = Recruit.where(date: date_from..date_end)
      @recruits = recruits.page(params[:page])
    elsif params[:practice_type]
      recruits = Recruit.where(practice_type: params[:practice_type])
      @recruits = recruits.page(params[:page])
    elsif params[:liked_posts]
      recruits = Recruit.all.liked_by(current_user)
      @recruits = recruits.page(params[:page])
    else
      recruits = Recruit.all
      @recruits = recruits.page(params[:page])
    end
    
    @recruits.each do |recruit|
      if recruit.date.before? Date.today
        recruit.update(open_status: false)
      end
    end
    
    like = Like.new
    @recruits.each do |recruit|
      @user = User.find(recruit.user_id)
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
