class Public::UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
  end
  
  def unsubscribe_confirm
    @user = User.find(params[:id])
  end
  
  def unsubscribe
    @user = User.find(params[:id])
  end
  
  private
  
  def users_parameter
    params.require(:user).permit(:id, :club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction)
  end
  
end
