class Public::EntriesController < ApplicationController
  
  def create
    @entry = Entry.new(entry_params)
    @recruit = Recruit.find(@entry.recruit_id)
    @entry.user_id = current_user.id
    @entry.save
    # 応募ステータスが応募済になったら、募集ステータスも候補者ありに更新
    if @entry.entry_status == "entered"
      @recruit.update(recruit_status: "having_candidates")
    end
    @recruit.create_nortification_entry(current_user, @entry)
    @recruit.create_nortification_match(current_user, @entry)
    @recruit.create_nortification_cancel(current_user, @entry)
    @recruit.create_nortification_match_rejected(current_user, @entry)
    # recruit_status = recruiting ?
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
    # 応募ステータスがマッチになったら、募集ステータスもマッチに更新
    # if @entry.entry_status == "match"
      # @recruit.update(recruit_status: "match" )
    # elsif @entry.entry_status == "match_rejected"
      # @recruit.update(recruit_status: "decline" )
    # end
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
