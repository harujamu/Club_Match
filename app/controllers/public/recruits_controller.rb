class Public::RecruitsController < ApplicationController
  
  def new
    @user = current_user
    @recruit = Recruit.new
    @recruit.user_id = @user.id
    @genre = Genre.find(@user.genre_id)
    @sites = @user.sites 
  end
  
  def create
    @recruit = Recruit.new(recruit_params)
    @user = current_user
    @recruit.user_id = @user.id
    @recruit.save
    redirect_to root_path
  end
  
  def show
    @recruit = Recruit.find(params[:id])
    @user = User.find(@recruit.user_id)
    @site = Site.find(@recruit.site_id)
    @entry = Entry.new
    @entry.user_id = current_user.id
    @entries = @recruit.entries
    @user_entry = current_user.entries.find_by(recruit_id: @recruit.id)
  end
  
  def edit
    @user = current_user
    @sites = @user.sites 
    @recruit = Recruit.find(params[:id])
    @genre = Genre.find(@user.genre_id)
  end

  def update
    @user = current_user
    @recruit = Recruit.find(params[:id])
    @recruit.update(recruit_params)
    redirect_to root_path
  end
  
  def index
    @user = current_user
    @recruits = @user.recruits
  end
  
  private
  
  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end
  
  def entry_params
    params.require(:entry).permit(:user_id, :recruit_id, :entry_status)
  end
  
  def user_params
    params.require(:user).permit(:club_name, :captain_last_name, :captain_first_name, :age_group, :genre_id, :prefecture, :municipality, :address, :introduction, :image, :email)
  end
  
  def site_params
    params.require(:site).permit(:prefecture, :municipality, :address, :user_id)
  end
  
end
