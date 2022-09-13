class Public::RecruitsController < ApplicationController
  
  def new
    @user = current_user
    @recruit = Recruit.new
    @recruit.user_id = @user.id
    @genre = Genre.find(@user.genre_id)
  end
  
  def create
    @recruit = Recruit.new(recruit_params)
    @user = current_user
    @recruit.user_id = @user.id
    @recruit.save
    redirect_to show_recruits_path(@recruit.id)
  end
  
  def show
    @user = User.find(params[:id])
    @recruit = Recruit.find(params[:id])
  end
  
  def edit
    @user = current_user
    @genre = Genre.find(@user.genre_id)
  end

  def update
    @user = current_user
    @recruit = Recruit.find(params[:id])
    @recruit.update(recruit_params)
    redirect_to show_recruits_path(@recruit.id)
  end
  
  private
  
  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end
  
  
  
end
