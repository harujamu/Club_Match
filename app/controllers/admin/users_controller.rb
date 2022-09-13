class Admin::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:id, :club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction)
  end
  
end
