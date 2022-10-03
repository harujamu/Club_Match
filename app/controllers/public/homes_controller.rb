class Public::HomesController < ApplicationController
  
  def top
    if params[:today_recruit]
      @recruits = Recruit.where(date: Date.today)
    elsif params[:date_from] && params[:date_end]
      recruits = Recruit.all
      recruits.each do |recruit|
        @recruits = Recruit.where(date: recruit.date.between?(params[:date_from],params[:date_end]))
      end
    else
      @recruits = Recruit.all
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
