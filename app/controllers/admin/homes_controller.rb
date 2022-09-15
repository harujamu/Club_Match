class Admin::HomesController < ApplicationController
  
  def top
    @users = User.all
  end
  
  private
  
  def user_params
    params.require(:user).permit(:club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction, :image, :email)
  end
end
