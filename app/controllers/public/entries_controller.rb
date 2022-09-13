class Public::EntriesController < ApplicationController
  
  def create
    @entry = Entry.new(entry_params)
    @entry.save
    redirect_to show_recruits_path(@recruit.id)
  end
  
  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
  end
  
  private
  
  def entry_params
    params.require(:entry).permit(:user_id, :recruit_id, :entry_status)
  end
  
end
