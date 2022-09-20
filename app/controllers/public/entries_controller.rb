class Public::EntriesController < ApplicationController
  
  def create
    @entry = Entry.new(entry_params)
    @recruit = Recruit.find(@entry.recruit_id)
    @entry.user_id = current_user.id
    @entry.save
    redirect_to recruit_path(@recruit.id)
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to entries_path
  end
  
  def index
    @user = current_user
    @entries = @user.entries
  end
  
  def update
    @entry = Entry.find(params[:id])
    @recruit = Recruit.find(@entry.recruit_id)
    @entry.update(entry_params)
    redirect_to recruit_path(@recruit.id)
  end
  
  private
  
  def entry_params
    params.require(:entry).permit(:user_id, :recruit_id, :entry_status)
  end
  
  def recruit_params
    params.require(:recruit).permit(:user_id, :site_id, :date, :title, :practice_type, :detail, :age_group, :recruit_status, :open_status)
  end
  
end
