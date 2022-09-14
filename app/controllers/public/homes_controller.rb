class Public::HomesController < ApplicationController
  
  def top
    @recruits = Recruit.all
    
    @recruits.each do |recruit|
      @user = User.find(recruit.user_id)
    end
    
  end
  
end
