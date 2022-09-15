class Public::HomesController < ApplicationController
  
  def top
    @recruits = Recruit.all
    
    @recruits.each do |recruit|
      @user = User.find(recruit.user_id)
    end
    
  end
  
  private
  
  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end
  
end
