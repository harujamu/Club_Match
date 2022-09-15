class Public::UsersController < ApplicationController
  
  def my_page
    @user = current_user
    @genre = Genre.find(@user.genre_id)
    @notifies = Notify.all
  end
  
  def show
    @user = User.find(params[:id])
    @genre = Genre.find(@user.genre_id)
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    @user.update(user_params)
    redirect_to my_page_path(@user)
  end
  
  def unsubscribe_confirm
    @user = current_user
  end
  
  def unsubscribe
    @user = current_user
  end
  
  private
  
  def user_params
    params.require(:user).permit(:club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction, :image, :email)
  end
  
  def genre_params
    params.require(:genre).permit(:name)
  end
  
end
